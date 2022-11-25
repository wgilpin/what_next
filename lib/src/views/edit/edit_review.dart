import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_next/src/controllers/firestore_db.dart';
import 'package:what_next/src/utils/layout.dart';
import 'package:what_next/src/views/edit/save_cancel.dart';
import 'package:what_next/src/views/edit/services_chooser.dart';
import 'package:what_next/src/views/edit/star_rating.dart';
import 'package:what_next/src/views/my_reviews/my_reviews_page.dart';

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
    Get.offAll(MyReviewsPage());
  }

  @override
  Widget build(BuildContext context) {
    _commentController.text = review.comment;
    return Material(
      child: Center(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(minWidth: 100, maxWidth: 400),
            child: Column(
              children: [
                addVerticalSpace(30),
                Image.network(
                  review.fullImageUrl,
                  height: 200,
                ),
                addVerticalSpace(10),
                Text(review.title),
                addVerticalSpace(10),
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
                addVerticalSpace(20),
                TextFormField(
                  controller: _commentController,
                  maxLines: null,
                  decoration:
                      const InputDecoration(hintText: 'Add your comment'),
                ),
                addVerticalSpace(20),
                ServicesChooser(
                    initialService: review.service,
                    onChanged: (service) => {
                          review.service = service,
                        }),
                addVerticalSpace(20),
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
