//https://www.youtube.com/watch?v=-H-T_BSgfOE
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthCtl extends GetxController {
  final FirebaseAuth auth;

  AuthCtl(this.auth);

  final Rxn<User> _firebaseUser = Rxn<User>();
  final verificationEmailSent = false.obs;

  User? get user => _firebaseUser.value;

  @override
  void onInit() {
    _firebaseUser.bindStream(auth.authStateChanges());
    super.onInit();
  }

  Future<void> createUser(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      Get.snackbar("Error creating account", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar("Unable to log in", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      Get.snackbar("Error signing out", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  refreshUser() async {
    try {
      await _firebaseUser.value?.reload();
    } catch (e) {
      Get.snackbar("Error refreshing user", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  verifyByEmail() async {
    try {
      await _firebaseUser.value?.sendEmailVerification();
      verificationEmailSent.value = true;
    } catch (e) {
      Get.snackbar("Error refreshing user", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
