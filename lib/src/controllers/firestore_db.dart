import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:what_next/src/controllers/auth_controller.dart';
import 'package:what_next/src/models/review.dart';

class FirestoreDB {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Review>> reviewStream(String uid) {
    print('in reviewStream');
    return _firestore
        .collection('reviews')
        .where('user', isEqualTo: uid)
        .snapshots()
        .map((QuerySnapshot query) {
      List<Review> reviews = [];
      for (var review in query.docs) {
        final reviewModel = Review.fromSnapshot(review);
        reviews.add(reviewModel);
      }
      return reviews;
    });
  }

  Future<void> addReview(Review review) {
    var authController = Get.find<AuthController>();
    if (authController.user == null) {
      return Future.error('User not logged in');
    }
    review.user = authController.user!.uid;
    return _firestore.collection('reviews').add(review.toMap());
  }
}
