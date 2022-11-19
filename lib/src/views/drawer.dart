import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_next/src/controllers/auth_controller.dart';
import 'package:what_next/src/views/friends_page.dart';
import 'package:what_next/src/views/login/login_page.dart';
import 'package:what_next/src/views/review/reviews_page.dart';

import 'my_reviews/my_reviews_page.dart';

Drawer getDrawer() {
  var controller = Get.find<AuthCtl>();
  return Drawer(
    child: Column(
      children: [
        ListView(
          shrinkWrap: true,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(controller.user?.displayName ?? 'User'),
            ),
            ListTile(
              title: const Text('Reviews'),
              leading: const Icon(Icons.recommend),
              onTap: () {
                Get.to(ReviewsPage());
              },
            ),
            ListTile(
              title: const Text('My Shows'),
              leading: const Icon(Icons.movie),
              onTap: () {
                Get.to(const MyReviewsPage());
              },
            ),
            ListTile(
              title: const Text('Friends'),
              leading: const Icon(Icons.groups),
              onTap: () {
                Get.to(FriendsPage());
              },
            ),
          ],
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ListTile(
              title: const Text('Log out'),
              leading: const Icon(Icons.logout),
              onTap: () async {
                var controller = Get.find<AuthCtl>();
                await controller.signOut();
                Get.to(LoginPage());
              },
            ),
          ),
        ),
      ],
    ),
  );
}
