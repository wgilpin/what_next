import 'package:flutter/material.dart';
import 'package:what_next/src/models/review.dart';
import 'package:what_next/src/views/recommend/show_widget.dart';

class FilmStrip extends StatelessWidget {
  const FilmStrip({super.key, required this.data});

  final List<Review> data;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        // shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ShowWidget(review:  data[index]);
        },
      ),
    );
  }
}
