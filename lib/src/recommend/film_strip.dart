import 'package:flutter/material.dart';
import 'package:what_next/src/recommend/show_widget.dart';

class FilmStrip extends StatelessWidget {
  const FilmStrip({super.key, required this.data});

  final List<Map<String, dynamic>> data;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ShowWidget(
              title: data[index]['title'],
              year: data[index]['year'],
              image: data[index]['image'],
              rating: data[index]['rating'],
              score: data[index]['score']);
        },
      ),
    );
  }
}
