import 'package:flutter/material.dart';
import 'package:what_next/src/models/review.dart';
import 'package:what_next/src/views/review/show_widget.dart';

class FilmGrid extends StatelessWidget {
  const FilmGrid({super.key, required this.data});

  final List<Review> data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200, mainAxisExtent: 300, childAspectRatio: .6),
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return ShowWidget(
            review: data[index],
          );
        },
      ),
    );
  }
}
