// ignore_for_file: prefer_const_constructors
// from : https://blog.logrocket.com/implementing-firebase-authentication-in-a-flutter-app/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_next/src/controllers/auth_controller.dart';
import 'package:what_next/src/utils/layout.dart';

class RegisterPage extends GetWidget<AuthCtl> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                    onPressed: () {
                      controller.createUser(
                          emailController.text, passwordController.text);
                      Get.back();
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )),
        ));
  }
}
