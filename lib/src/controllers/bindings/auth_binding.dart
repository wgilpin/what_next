import 'package:get/get.dart';
import 'package:what_next/src/controllers/auth_controller.dart';
import 'package:what_next/src/controllers/reviews_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthCtl());
    Get.put(ReviewsCtl());
  }
}
