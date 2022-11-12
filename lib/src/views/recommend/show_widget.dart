import 'package:flutter/material.dart';
import 'package:what_next/src/views/edit/star_rating.dart';
import 'package:what_next/src/models/review.dart';

class ShowWidget extends StatelessWidget {
  const ShowWidget({
    super.key,
    required this.review,
  });

  final Review review;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 300),
      child: Card(
        child: Column(
          children: [
            Image.network(
              review.fullImageUrl,
              height: 200,
            ),
            const SizedBox(height: 10),
            Text(review.title),
            const SizedBox(height: 10),
            Center(
              child: StarRating(
                rating: review.rating,
              ),
            )
          ],
        ),
      ),
    );
  }
}
