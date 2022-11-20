import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:what_next/src/controllers/my_reviews_controller.dart';
import 'package:what_next/src/controllers/show_search_controller.dart';
import 'package:what_next/src/models/review.dart';
import 'package:what_next/src/utils/layout.dart';
import 'package:what_next/src/views/drawer.dart';
import 'package:what_next/src/views/edit/edit_review.dart';
import 'package:what_next/src/views/edit/find_show.dart';
import 'package:what_next/src/views/review/film_grid.dart';

class MyReviewsPage extends GetWidget<MyReviewsCtl> {
  final searcher = Get.put(ShowSearchCtl());

  MyReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('My Shows'),
      // ),
      drawer: getDrawer(),
      body: Stack(
        children: [
          Expanded(
            child: Column(
              children: [
                addVerticalSpace(60),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'My Reviews',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                Obx(() {
                  if (controller.reviews.isEmpty) {
                    return const Center(
                      child: Text('No shows added yet'),
                    );
                  } else {
                    return Expanded(child: FilmGrid(data: controller.reviews));
                  }
                }),
              ],
            ),
          ),
          buildFloatingSearchBar(context),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const FindShowForm());
        },
        tooltip: 'Add Show',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildFloatingSearchBar(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Search for shows',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        if (query.length > 3) {
          doSearch(query);
        }
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            elevation: 4.0,
            child: Obx(() => Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: searcher.searchResults.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            leading: const Icon(Icons.person),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  constraints:
                                      const BoxConstraints(maxWidth: 300),
                                  child: Text(
                                    searcher.searchResults[index].title,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                TextButton(
                                    child: const Text('save show'),
                                    onPressed: () => Get.to(EditReview(
                                        review: Review.fromMovie(
                                            searcher.searchResults[index])))),
                              ],
                            ));
                      }),
                )),
          ),
        );
      },
    );
  }

  void doSearch(String query) {
    searcher.search(text: query);
  }
}
