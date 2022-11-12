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
    reviewList.bindStream(FirestoreDB().reviewStream(uid));
    print('MyReviewsController bound to stream');
  }
}
