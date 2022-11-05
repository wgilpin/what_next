import 'dart:math';

import 'package:flutter/material.dart';
import 'package:what_next/src/recommend/film_strip.dart';
import 'package:what_next/src/recommend/show_widget.dart';

class RecommendsPage extends StatefulWidget {
  const RecommendsPage({super.key});

  @override
  State<RecommendsPage> createState() => _RecommendsPageState();
}

class _RecommendsPageState extends State<RecommendsPage> {
  // generate random array of maps
  List<List<Map<String, dynamic>>> _generateRandomList(int size) {
    List<List<Map<String, dynamic>>> list = [];
    int rowCount = 4;
    int colCount = 6;
    var dates = Random();
    for (int r = 0; r < rowCount; r++) {
      List<Map<String, dynamic>> row = [];
      for (int c = 0; c < colCount; c++) {
        row.add({
          'title': 'Title $r$c',
          'year': 1980 + dates.nextInt(40),
          'image': 'https://picsum.photos/id/${colCount * r + c}/300/200',
          'rating': 1 + dates.nextInt(10),
          'score': dates.nextInt(100),
        });
      }
      list.add(row);
    }

    return list;
  }

  List<List<Map<String, dynamic>>> data = [];

  _RecommendsPageState() {
    data = _generateRandomList(10);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [];

    for (var i = 0; i < data.length; i++) {
      // rows.add(Text('Row $i'));
      // rows.add(const SizedBox(height: 10));
      rows.add(SizedBox(height: 300, child: FilmStrip(data: data[i])));
    }

    return Material(
      child: ListView(children: rows),
    );
  }
}
