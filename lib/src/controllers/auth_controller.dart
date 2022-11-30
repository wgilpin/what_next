//https://www.youtube.com/watch?v=-H-T_BSgfOE
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:what_next/src/views/login/login_page.dart';
import 'package:what_next/src/views/review/reviews_page.dart';

/// Controller for authentication
class AuthCtl extends GetxController {
  final FirebaseAuth auth;

  /// Inject FirebaseAuth dependency for testing
  AuthCtl(this.auth);

  Rxn<User> _firebaseUser = Rxn<User>();

  /// Has the verification link been sent?
  final verificationEmailSent = false.obs;

  /// The firebase user object, or null if not logged in
  User? get user => _firebaseUser.value;

  @override
  void onInit() {
    _firebaseUser = Rxn<User>(auth.currentUser);
    _firebaseUser.bindStream(auth.authStateChanges());
    ever(_firebaseUser, _setInitialScreen);
    super.onInit();
  }

  _setInitialScreen(User? user) {
    if (user != null) {
      //User Logged IN
      Get.to(ReviewsPage());
    } else {
      //User Logged out
      Get.to(LoginPage());
    }
  }

  /// Create a new user with email and password
  Future<void> createUser(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      Get.snackbar("Error creating account", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  /// Sign in with email and password
  Future<void> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar("Unable to log in", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  /// Sign out the current user
  signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      Get.snackbar("Error signing out", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  /// Refresh the current user, fore example after email verification
  refreshUser() async {
    try {
      await _firebaseUser.value?.reload();
    } catch (e) {
      Get.snackbar("Error refreshing user", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  /// Send a verification email for a new user
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
