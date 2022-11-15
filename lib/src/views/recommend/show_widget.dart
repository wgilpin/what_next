import 'package:flutter/material.dart';
import 'package:what_next/src/utils/layout.dart';
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
      constraints: const BoxConstraints(maxHeight: 300, maxWidth: 180),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.network(
                review.fullImageUrl,
                height: 200,
              ),
              addVerticalSpace(10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  review.title,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              addVerticalSpace(10),
              Center(
                child: StarRating(
                  rating: review.rating,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
