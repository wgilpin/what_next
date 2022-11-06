import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_next/src/controllers/my_reviews_controller.dart';
import 'package:what_next/src/recommend/show_widget.dart';

class MyMoviesPage extends StatelessWidget {
  MyMoviesPage({super.key});

  final myMoviesController = Get.put(MyReviewsController());

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemCount: myMoviesController.myMovies.length,
        itemBuilder: (context, index) => Card(
          child: ShowWidget(review: myMoviesController.myMovies[index]),
        ),
      ),
    );
  }
}
