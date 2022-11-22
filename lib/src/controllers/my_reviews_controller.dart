import 'package:get/get.dart';
import 'package:what_next/src/controllers/auth_controller.dart';
import 'package:what_next/src/controllers/firestore_db.dart';

import '../models/review.dart';

class MyReviewsCtl extends GetxController {
  RxList<Review> reviewList = RxList<Review>([]);

  List<Review> get reviews => reviewList;

  @override
  void onReady() {
    super.onReady();
    var uid = Get.find<AuthCtl>().user!.uid;
    reviewList.bindStream(FirestoreDB().reviewsForUserStream(uid));
    print('MyReviewsController bound to stream');
  }

  // if I have a review for this show, return it. If not, return null
  Future<Review?> getMyReview(String showId) async {
    var uid = Get.find<AuthCtl>().user!.uid;
    return FirestoreDB()
        .firestore
        .collectionGroup('review')
        .where('user', isEqualTo: uid)
        .where('movie_id', isEqualTo: showId)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return Review.fromSnapshot(snapshot.docs[0]);
      }
    });
  }
}
