import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_next/src/controllers/genre_controller.dart';
import 'package:what_next/src/controllers/my_reviews_controller.dart';
import 'package:what_next/src/controllers/reviews_controller.dart';
import 'package:what_next/src/models/review.dart';
import 'package:what_next/src/utils/layout.dart';
import 'package:what_next/src/views/drawer.dart';
import 'package:what_next/src/views/edit/find_show.dart';
import 'package:what_next/src/views/review/film_strip.dart';

class ReviewsPage extends StatelessWidget {
  final MyReviewsCtl myReviewsController = Get.put(MyReviewsCtl());
  final ReviewsCtl reviewsController = Get.put(ReviewsCtl());
  final GenreCtl genreController = Get.put(GenreCtl());

  ReviewsPage({super.key});

  final RxList<List<Review>> data = RxList<List<Review>>([]);
  final RxList<String> labels = RxList<String>([]);
  RxInt genreIdFilter = RxInt(-1);

  @override
  Widget build(BuildContext context) {
    labels.add('My Reviews');
    data.add(myReviewsController.reviews);
    labels.add("Other People's");
    data.add(reviewsController.reviews);
    data.refresh();
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
          labels.clear();
          data.clear();
          labels.add('My Reviews');
          data.add(myReviewsController.reviews);
          labels.add("Other People's");
          data.add(reviewsController.reviews);
          print('data: ${data.length}');
          return Column(children: [
            if (genreIdFilter.value >= 0)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    'Showing ${genreController.genres[genreIdFilter.value]}'),
              ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          labels[index],
                          textAlign: TextAlign.left,
                        ),
                        addVerticalSpace(10),
                        if (data[index].isEmpty)
                          const Text('      No shows here'),
                        if (data[index].isNotEmpty)
                          FilmStrip(
                              data: data[index], genre: genreIdFilter.value),
                      ],
                    ),
                  );
                }),
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
