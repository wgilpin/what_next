import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_next/src/controllers/movie_search_controller.dart';
import 'package:what_next/src/utils/layout.dart';
import 'package:what_next/src/views/edit/edit_review.dart';
import 'package:what_next/src/views/edit/movie_search_tile.dart';
import 'package:what_next/src/views/edit/save_cancel.dart';

import '../../models/movie.dart';
import '../../models/review.dart';

class FindShowForm extends StatefulWidget {
  const FindShowForm({super.key});

  @override
  State<FindShowForm> createState() => _FindShowFormState();
}

class _FindShowFormState extends State<FindShowForm> {
  final _formKey = GlobalKey<FormState>();
  String searchText = '';
  final searcher = Get.put(MovieSearchCtl());

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    Future<void> doSave() async {
      if (searchText.length > 3) {
        // If the text is valid, display a snackbar.
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Processing Data')),
        );
        await searcher.search(text: searchText);
        print([for (var r in searcher.searchResults) r.title]);
      }
    }

    return Material(
      child: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            constraints: const BoxConstraints(minWidth: 100, maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  autofocus: true,
                  decoration: const InputDecoration(hintText: 'Movie name?'),
                  onChanged: (text) {
                    searchText = text;
                  },
                  onSubmitted: (_) => {doSave()},
                ),
                addVerticalSpace(40),
                SaveCancel(
                    saveLbl: 'Search', onSave: doSave, cancelLbl: 'Cancel'),
                Expanded(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 300),
                    padding: const EdgeInsets.all(8.0),
                    child: GetBuilder<MovieSearchCtl>(
                      builder: (controller) {
                        return ListView.builder(
                          itemCount: controller.searchResults.length,
                          itemBuilder: (context, index) {
                            Movie movie = controller.searchResults[index];
                            Review review = Review.fromMovie(movie);
                            return MovieSearchTile(
                              movie: movie,
                              onTap: () => Get.to(EditReview(review: review)),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
