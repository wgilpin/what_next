import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_next/src/controllers/auth_controller.dart';
import 'package:what_next/src/controllers/reviews_controller.dart';
import 'package:what_next/src/controllers/service_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthCtl());
    Get.put(ReviewsCtl());
    Get.put(ServiceCtl());
    debugPrint('Bindings set');
  }
}
