import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ShowWidget extends StatelessWidget {
  const ShowWidget(
      {super.key,
      required this.title,
      required this.year,
      required this.image,
      required this.rating,
      required this.score});

  final String title;
  final int year;
  final String image;
  final int rating;
  final int score;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Card(
        child: Column(
          children: [
            Image.network(image),
            SizedBox(height: 10),
            Text(title),
          ],
        ),
      ),
    );
  }
}
