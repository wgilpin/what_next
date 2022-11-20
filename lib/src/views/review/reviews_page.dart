import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_next/src/controllers/genre_controller.dart';
import 'package:what_next/src/controllers/my_reviews_controller.dart';
import 'package:what_next/src/controllers/reviews_controller.dart';
import 'package:what_next/src/models/review.dart';
import 'package:what_next/src/utils/layout.dart';
import 'package:what_next/src/views/drawer.dart';
import 'package:what_next/src/views/edit/find_show.dart';
import 'package:what_next/src/views/review/film_grid.dart';
import 'package:what_next/src/views/review/film_strip.dart';

class ReviewsPage extends StatelessWidget {
  final MyReviewsCtl myReviewsController = Get.put(MyReviewsCtl());
  final ReviewsCtl reviewsController = Get.put(ReviewsCtl());
  final GenreCtl genreController = Get.put(GenreCtl());

  ReviewsPage({super.key});

  final RxList<Review> _myReviews = RxList<Review>([]);
  final RxList<Review> _allReviews = RxList<Review>([]);
  RxInt genreIdFilter = RxInt(-1);

  @override
  Widget build(BuildContext context) {
    _myReviews.addAll(myReviewsController.reviews);
    _allReviews.addAll(reviewsController.reviews);
    _myReviews.refresh();
    _allReviews.refresh();
    return Scaffold(
      appBar: AppBar(
        title: const Text('What Next'),
        actions: [
          TextButton.icon(
              onPressed: openFilters,
              icon: const Icon(Icons.filter),
              label: const Text('Filters'))
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          _myReviews.clear();
          _allReviews.clear();
          _myReviews.addAll(myReviewsController.reviews);
          _allReviews.addAll(reviewsController.reviews);
          print('data: ${_myReviews.length}');
          return Column(children: [
            if (genreIdFilter.value >= 0)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    'Showing ${genreController.genres[genreIdFilter.value]}'),
              ),
            const Text(
              'My Reviews',
              textAlign: TextAlign.left,
            ),
            addVerticalSpace(10),
            if (_myReviews.isEmpty) const Text('      No shows here'),
            if (_myReviews.isNotEmpty)
              FilmStrip(data: _myReviews, genre: genreIdFilter.value),
            const Text(
              'Recommended',
              textAlign: TextAlign.left,
            ),
            addVerticalSpace(10),
            if (_allReviews.isEmpty) const Text('      No shows here'),
            if (_allReviews.isNotEmpty)
              Expanded(
                  child:
                      FilmGrid(data: _allReviews, genre: genreIdFilter.value)),
          ]);
        }),
      ),
      drawer: getDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const FindShowForm());
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }

  void openFilters() {
    Get.bottomSheet(
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      SizedBox(
          height: 300,
          // color: Colors.greenAccent,
          child: Column(children: [
            if (genreIdFilter >= 0)
              TextButton(
                  onPressed: () => doFilter(-1),
                  child: const Text(
                    'Clear Filter',
                    style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline),
                  )),
            GridView.builder(
                shrinkWrap: true,
                itemCount: genreController.genreCount,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 150, childAspectRatio: 4),
                itemBuilder: (context, index) {
                  var style =
                      genreIdFilter.value == genreController.genreIdAt(index)
                          ? const TextStyle(
                              color: Colors.white,
                              backgroundColor: Colors.black26)
                          : const TextStyle(color: Colors.blue);
                  return TextButton(
                      onPressed: () => doFilter(index),
                      child: Text(
                        genreController.genreNameAt(index),
                        style: style,
                      ));
                }),
          ])),
      isDismissible: true,
      enableDrag: true,
    );
  }

  doFilter(int idx) {
    if (idx == -1) {
      // clear filter
      genreIdFilter.value = -1;
      debugPrint('Filters cleared');
    } else {
      genreIdFilter.value = genreController.genreIdAt(idx);
      debugPrint(
          'Filtering on $genreIdFilter.value = ${genreController.genreNameAt(idx)}');
    }
    Get.back();
  }
}
