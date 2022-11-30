import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_next/src/controllers/auth_controller.dart';
import 'package:what_next/src/controllers/genre_controller.dart';
import 'package:what_next/src/controllers/my_reviews_controller.dart';
import 'package:what_next/src/controllers/reviews_controller.dart';
import 'package:what_next/src/controllers/service_controller.dart';

class AppBindings extends Bindings {
  /// Bindings are used to inject dependencies into GetX.
  @override
  void dependencies() {
    Get.put(AuthCtl(FirebaseAuth.instance));
    Get.put(ReviewsCtl());
    Get.put(MyReviewsCtl());
    Get.put(ServiceCtl());
    Get.put(GenreCtl());

    debugPrint('Bindings set');
  }
}
