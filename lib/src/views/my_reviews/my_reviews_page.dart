import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_next/src/controllers/my_reviews_controller.dart';
import 'package:what_next/src/views/drawer.dart';
import 'package:what_next/src/views/edit/find_show.dart';
import 'package:what_next/src/views/review/show_widget.dart';

class MyReviewsPage extends GetWidget<MyReviewsCtl> {
  const MyReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shows'),
      ),
      drawer: getDrawer(),
      body: Obx(() {
        if (controller.reviews.isEmpty) {
          return const Center(
            child: Text('No shows added yet'),
          );
        } else {
          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 200),
              child: ListView.builder(
                itemCount: controller.reviews.length,
                itemBuilder: (BuildContext context, int index) {
                  return ShowWidget(
                    review: controller.reviews[index],
                  );
                },
              ),
            ),
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const FindShowForm());
        },
        tooltip: 'Add Show',
        child: const Icon(Icons.add),
      ),
    );
  }
}
