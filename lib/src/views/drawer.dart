import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_next/src/controllers/auth_controller.dart';
import 'package:what_next/src/views/recommend/recommends_page.dart';

import 'my_movies/my_movies.dart';

Drawer getDrawer() {
  var controller = Get.find<AuthController>();
  return Drawer(
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(controller.user?.displayName ?? 'User'),
        ),
        ListTile(
          title: const Text('Recomended'),
          onTap: () {
            Get.to(const RecommendsPage());
          },
        ),
        ListTile(
          title: const Text('My Shows'),
          onTap: () {
            Get.to(const MyMoviesPage());
          },
        ),
      ],
    ),
  );
}
