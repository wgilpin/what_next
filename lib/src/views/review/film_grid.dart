import 'package:flutter/material.dart';
import 'package:what_next/src/models/review.dart';
import 'package:what_next/src/views/review/show_widget.dart';

class FilmGrid extends StatelessWidget {
  const FilmGrid({super.key, required this.data, required this.genre});

  final List<Review> data;
  final int genre;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200, childAspectRatio: .6),
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          if (genre < 0 || data[index].genreIds.contains(genre)) {
            return ShowWidget(
              review: data[index],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
