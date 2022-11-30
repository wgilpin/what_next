import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:what_next/src/controllers/auth_controller.dart';
import 'package:what_next/src/controllers/firestore_db.dart';

import '../models/review.dart';

class ReviewsCtl extends GetxController {
  final FirebaseFirestore firestore;

  // DI of firestore for testing
  ReviewsCtl([FirebaseFirestore? firestore])
      : firestore = firestore ?? FirebaseFirestore.instance;

  final RxList<Review> _reviewList = RxList<Review>([]);
  final RxList<Review> reviewsForShowList = RxList<Review>([]);
  List<Review> get reviews => _reviewList;

  @override
  void onReady() {
    super.onReady();
    _reviewList.bindStream(FirestoreDB(firestore).reviewsForUserStream());
    debugPrint('ReviewsController bound to stream');
  }

  Future<List<Review>> getReviewsForShow(String showId) {
    return firestore
        .collectionGroup('reviews')
        .where('movie_id', isEqualTo: showId)
        .get()
        .then((QuerySnapshot query) {
      List<Review> reviewsForShow = [];
      for (var review in query.docs) {
        final reviewModel = Review.fromSnapshot(review);
        reviewsForShow.add(reviewModel);
      }
      debugPrint('reviews for show $showId: ${reviewsForShow.length}');
      return reviewsForShow;
    });
  }
}
