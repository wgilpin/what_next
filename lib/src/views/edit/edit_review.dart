import 'package:flutter/material.dart';
import 'package:what_next/src/views/edit/save_cancel.dart';
import 'package:what_next/src/views/edit/star_rating.dart';

import '../../models/review.dart';

class EditReview extends StatelessWidget {
  const EditReview({super.key, required this.review});

  final Review review;

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
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const SaveCancel(saveLbl: 'Save', cancelLbl: 'Cancel'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
