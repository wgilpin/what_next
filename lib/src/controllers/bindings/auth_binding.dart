import 'package:get/get.dart';
import 'package:what_next/src/controllers/auth_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthCtl());
  }
}
