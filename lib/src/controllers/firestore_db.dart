import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:what_next/src/controllers/auth_controller.dart';
import 'package:what_next/src/models/show.dart';
import 'package:what_next/src/models/review.dart';
import "package:collection/collection.dart";

class FirestoreDB {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<Review>> reviewsForUserStream(String uid) {
    debugPrint('in reviewsForUserStream');
    return firestore
        .collectionGroup('reviews')
        .where('user', isEqualTo: uid)
        .snapshots()
        .map((QuerySnapshot query) {
      List<Review> reviews = [];
      for (var review in query.docs) {
        final reviewModel = Review.fromSnapshot(review);
        reviews.add(reviewModel);
      }

      debugPrint('review stream:${reviews.length}');
      return reviews;
    });
  }

  Stream<List<Review>> reviewsStream(String uid) {
    return firestore
        .collectionGroup('reviews')
        .orderBy('when', descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<Review> rawReviews = [];
      for (var review in query.docs) {
        final reviewModel = Review.fromSnapshot(review);
        rawReviews.add(reviewModel);
      }
      var reviews = processReviews(rawReviews: rawReviews, user: uid);
      return reviews;
    });
  }

  Future<void> addMovie(Show movie) async {
    var showsSnap = await firestore.collection('movies').doc(movie.id).get();
    if (!showsSnap.exists) {
      firestore.collection('movies').doc(movie.id).set({
        'title': movie.title,
        'posterPath': movie.posterPath,
        'genre_ids': movie.genreIds,
      });
    }
  }

  Future<void> addReview(Review review) async {
    var authController = Get.find<AuthCtl>();
    if (authController.user == null) {
      return Future.error('User not logged in');
    }
    review.user = authController.user!.uid;
    await addMovie(review);
    await firestore
        .collection('movies')
        .doc(review.movieId)
        .collection('reviews')
        .doc(review.user)
        .set(review.toMap());
  }

  // remove duplicate reviews and work out average ratings
  static List<Review> processReviews(
      {required List<Review> rawReviews, required String user}) {
    List<Review> results = [];
    var groups = groupBy(rawReviews, (Review r) => r.movieId);
    for (var id in groups.keys) {
      var reviews = groups[id]!;
      // ignore any group if I am the only reviewer
      if (reviews.length == 1 && reviews[0].user == user) {
        continue;
      }
      var rating = reviews
              .map((r) => r.rating)
              .fold<double>(0.0, (acc, val) => acc + val) /
          reviews.length;
      var first = reviews.first;
      first.rating = rating;
      results.add(first);
    }
    return results;
  }
}
