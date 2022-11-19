import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_next/src/controllers/auth_controller.dart';
import 'package:what_next/src/views/login/login_page.dart';
import 'package:what_next/src/views/review/reviews_page.dart';

class Root extends GetWidget<AuthCtl> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.user == null) {
        return LoginPage();
      } else {
        return ReviewsPage();
      }
    });
  }
}
