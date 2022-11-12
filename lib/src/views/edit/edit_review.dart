import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_next/src/controllers/firestore_db.dart';
import 'package:what_next/src/views/edit/save_cancel.dart';
import 'package:what_next/src/views/edit/star_rating.dart';
import 'package:what_next/src/views/my_movies/my_movies_page.dart';

import '../../models/review.dart';

class EditReview extends StatelessWidget {
  EditReview({super.key, required this.review});

  final Review review;
  final TextEditingController _commentController = TextEditingController();

  _doSave() async {
    review.comment = _commentController.text;
    await FirestoreDB().addReview(review);
    _commentController.clear();
    Get.snackbar("Saved", review.title, snackPosition: SnackPosition.BOTTOM);
    Get.offAll(const MyMoviesPage());
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(minWidth: 100, maxWidth: 400),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Image.network(
                  review.fullImageUrl,
                  height: 200,
                ),
                const SizedBox(height: 10),
                Text(review.title),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StarRating(
                      rating: review.rating,
                      onRatingChanged: (rating) => {
                        review.rating = rating,
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _commentController,
                  decoration:
                      const InputDecoration(hintText: 'Add your comment'),
                ),
                const SizedBox(height: 20),
                SaveCancel(
                  saveLbl: 'Save',
                  onSave: _doSave,
                  cancelLbl: 'Cancel',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
