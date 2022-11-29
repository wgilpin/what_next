import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:what_next/src/controllers/auth_controller.dart';

class MockAuthCtl extends AuthCtl with Mock {
  late MockFirebaseAuth _mockAuth;

  MockAuthCtl(super.auth);

  @override
  void onInit() async {
    final user = MockUser(
      isAnonymous: false,
      uid: 'user1',
      email: 'bob@somedomain.com',
      displayName: 'Bob',
    );
    _mockAuth = MockFirebaseAuth(mockUser: user, signedIn: true);
    super.onInit();
  }

  @override
  User? get user => _mockAuth.currentUser;

  @override
  Future<void> createUser(String email, String password) async {
    await _mockAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> login(String email, String password) async {
    await _mockAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  signOut() async {
    await _mockAuth.signOut();
  }

  @override
  refreshUser() async {
    await _mockAuth.currentUser?.reload();
  }

  @override
  verifyByEmail() async {
    await Future.delayed(0.3.seconds);
    verificationEmailSent.value = true;
  }
}
