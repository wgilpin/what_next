// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_next/src/controllers/auth_controller.dart';
import 'package:what_next/src/utils/layout.dart';
import 'package:what_next/src/views/login/login_page.dart';

class ProfilePage extends GetWidget<AuthCtl> {
  ProfilePage();

  final _isSendingVerification = false.obs;
  final _isSigningOut = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'NAME: ${controller.user?.displayName}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            addVerticalSpace(16),
            Text(
              'EMAIL: ${controller.user?.email}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            addVerticalSpace(16),
            controller.user!.emailVerified
                ? Text(
                    'Email verified',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.green),
                  )
                : Column(
                    children: [
                      Text(
                        'Email not verified',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.red),
                      ),
                    ],
                  ),
            addVerticalSpace(16),
            _isSendingVerification.value
                ? CircularProgressIndicator()
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await controller.verifyByEmail();
                          _isSendingVerification.value = true;
                        },
                        child: Text('Verify email'),
                      ),
addVerticalSpace(8),                      IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () async {
                          await controller.refreshUser();
                        },
                      ),
                    ],
                  ),
            addVerticalSpace(16),
            _isSigningOut.value
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      _isSigningOut.value = true;
                      await FirebaseAuth.instance.signOut();
                      _isSigningOut.value = false;
                      Get.to(LoginPage());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text('Sign out'),
                  ),
          ],
        ),
      ),
    );
  }
}
