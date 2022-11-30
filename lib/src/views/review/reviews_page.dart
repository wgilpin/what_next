import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_next/src/controllers/genre_controller.dart';
import 'package:what_next/src/controllers/my_reviews_controller.dart';
import 'package:what_next/src/controllers/reviews_controller.dart';
import 'package:what_next/src/models/review.dart';
import 'package:what_next/src/utils/layout.dart';
import 'package:what_next/src/views/drawer.dart';
import 'package:what_next/src/views/edit/find_show.dart';
import 'package:what_next/src/views/friends_page.dart';
import 'package:what_next/src/views/review/film_grid.dart';
import 'package:what_next/src/views/review/film_strip.dart';
import 'package:what_next/src/views/review/review_details_page.dart';

class ReviewsPage extends StatelessWidget {
  final MyReviewsCtl myReviewsController = Get.find<MyReviewsCtl>();
  final ReviewsCtl reviewsController = Get.find<ReviewsCtl>();
  final GenreCtl genreController = Get.find<GenreCtl>();

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
          applyFilter();
          return Column(children: [
            if (genreIdFilter.value >= 0)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    'Showing ${genreController.genres[genreIdFilter.value]}'),
              ),
            addVerticalSpace(20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                ' My Reviews',
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.left,
              ),
            ),
            addVerticalSpace(10),
            if (_myReviews.isEmpty)
              if (genreIdFilter < 0)
                Column(
                  children: [
                    const Text('      No shows here'),
                    addVerticalSpace(20),
                    ElevatedButton.icon(
                      onPressed: () => Get.to(const FindShowForm()),
                      icon: const Icon(Icons.edit),
                      label: const Text('Add your first review'),
                    ),
                  ],
                )
              else
                const Text('    No shows in this genre'),
            if (_myReviews.isNotEmpty)
              FilmStrip(
                data: _myReviews,
                onTapShow: showDetails,
              ),
            addVerticalSpace(30),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                ' Recommended',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            addVerticalSpace(10),
            if (_allReviews.isEmpty)
              Column(
                children: [
                  const Text('      No shows yet'),
                  addVerticalSpace(40),
                  if (genreIdFilter < 0)
                    Column(
                      children: [
                        const Text(
                            '      Reviews your friends add will appear here'),
                        addVerticalSpace(30),
                        ElevatedButton.icon(
                            onPressed: () => Get.to(FriendsPage()),
                            icon: const Icon(Icons.person_add),
                            label: const Text('Add a friend'))
                      ],
                    )
                  else
                    const Text('    No shows in this genre'),
                ],
              ),
            if (_allReviews.isNotEmpty)
              Expanded(
                  child: FilmGrid(
                data: _allReviews,
                onTapShow: showDetails,
              )),
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

  void showDetails(String reviewId) {
    Get.to(ReviewDetailsPage(reviewId: reviewId));
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
    // update local lists for filter
    applyFilter();
    Get.back();
  }

  void applyFilter() {
    _myReviews.clear();
    _allReviews.clear();
    if (genreIdFilter >= 0) {
      // apply filter
      _myReviews.addAll(myReviewsController.reviews
          .where((show) => show.genreIds.contains(genreIdFilter.value)));
      _allReviews.addAll(reviewsController.reviews
          .where((show) => show.genreIds.contains(genreIdFilter.value)));
    } else {
      // clear filters
      _myReviews.addAll(myReviewsController.reviews);
      _allReviews.addAll(reviewsController.reviews);
    }
  }
}
