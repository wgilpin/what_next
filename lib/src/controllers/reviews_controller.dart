import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:what_next/src/controllers/auth_controller.dart';
import 'package:what_next/src/controllers/firestore_db.dart';

import '../models/review.dart';

class ReviewsCtl extends GetxController {
  RxList<Review> reviewList = RxList<Review>([]);
  RxList<Review> reviewsForShowList = RxList<Review>([]);

  List<Review> get reviews => reviewList;

  Future<List<Review>> getReviewsForShow(String showId) {
    return FirestoreDB()
        .firestore
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

  @override
  void onReady() {
    super.onReady();
    var uid = Get.find<AuthCtl>().user!.uid;
    reviewList.bindStream(FirestoreDB().reviewsStream(uid));
    // reviewsForShowList.bindStream(reviewsForShowStream());
  }
}
