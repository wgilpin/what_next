import 'package:get/get.dart';
import 'package:what_next/src/controllers/firestore_db.dart';

import '../models/review.dart';

class MyReviewsController extends GetxController {
  var myMovies = <Review>[].obs;

  @override
  void onInit() {
    super.onInit();
    myMovies.bindStream(FirestoreDB().getMyMovies());
  }
}
