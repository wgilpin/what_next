// ignore_for_file: prefer_const_constructors
// from : https://www.youtube.com/watch?v=-H-T_BSgfOE&t=646s

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_next/src/controllers/auth_controller.dart';
import 'package:what_next/src/utils/layout.dart';
import 'package:what_next/src/views/login/register_page.dart';
import 'package:what_next/src/views/review/reviews_page.dart';

class LoginPage extends GetWidget<AuthCtl> {
  final TextEditingController emailCtl = TextEditingController();
  final TextEditingController passwordCtl = TextEditingController();

  void showSnack(text) => Get.snackbar('Error', text,
      icon: Icon(
        Icons.warning,
        color: Colors.red,
      ),
      snackPosition: SnackPosition.BOTTOM);

  Future<void> doLogin() async {
    if (!GetUtils.isEmail(emailCtl.text)) {
      showSnack('Not a valid email address');
      return;
    }
    await controller.login(emailCtl.text, passwordCtl.text);
    if (controller.user != null) {
      Get.offAll(ReviewsPage());
    } else {
      Get.offAll(LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Center(
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Email'),
                    controller: emailCtl,
                  ),
                  addVerticalSpace(40),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Password'),
                    controller: passwordCtl,
                    obscureText: true,
                  ),
                  addVerticalSpace(40),
                  ElevatedButton(
                    onPressed: doLogin,
                    child: Text(
                      'Log in',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  addVerticalSpace(40),
                  TextButton(
                    onPressed: () {
                      Get.to(RegisterPage());
                    },
                    child: Text('Register'),
                  ),
                ],
              )),
        ));
  }
}
