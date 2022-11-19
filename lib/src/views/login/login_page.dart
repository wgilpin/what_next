// ignore_for_file: prefer_const_constructors
// from : https://www.youtube.com/watch?v=-H-T_BSgfOE&t=646s

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_next/src/controllers/auth_controller.dart';
import 'package:what_next/src/utils/layout.dart';
import 'package:what_next/src/utils/root.dart';
import 'package:what_next/src/views/login/register_page.dart';
import 'package:what_next/src/views/review/reviews_page.dart';

class LoginPage extends GetWidget<AuthCtl> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> doLogin() async {
    await controller.login(emailController.text, passwordController.text);
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
                    controller: emailController,
                  ),
                  addVerticalSpace(40),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Password'),
                    controller: passwordController,
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
