import 'package:flutter/material.dart';
import 'package:what_next/src/models/review.dart';
import 'package:what_next/src/views/review/show_widget.dart';

class FilmStrip extends StatelessWidget {
  const FilmStrip({super.key, required this.data, required this.onTapShow});

  final List<Review> data;
  final Function(String id) onTapShow;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ShowWidget(
                  review: data[index],
                  onTap: onTapShow,
                );
              },
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
