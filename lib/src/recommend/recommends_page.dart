import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_next/src/edit/edit_show.dart';
import 'package:what_next/src/models/review.dart';
import 'package:what_next/src/recommend/film_strip.dart';

class RecommendsPage extends StatefulWidget {
  const RecommendsPage({super.key});

  @override
  State<RecommendsPage> createState() => _RecommendsPageState();
}

class _RecommendsPageState extends State<RecommendsPage> {
  // generate random array of maps
  List<List<Review>> _generateRandomList(int size) {
    List<List<Review>> list = [];
    int rowCount = 4;
    int colCount = 6;
    var dates = Random();
    for (int r = 0; r < rowCount; r++) {
      List<Review> row = [];
      for (int c = 0; c < colCount; c++) {
        row.add(Review(
          title: 'Title $r$c',
          movie: '1',
          posterPath: '/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg',
          logo: 'https://picsum.photos/id/${colCount * r + c}/300/200',
          rating: (1 + dates.nextInt(10)).toDouble(),
          service: 'Netflocks',
          user: FirebaseAuth.instance.currentUser?.toString() ?? '0',
          when: DateTime.now(),
        ));
      }
      list.add(row);
    }

    return list;
  }

  List<List<Review>> data = [];

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('What Next'),
      ),
      body: ListView(scrollDirection: Axis.vertical, children: rows),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(EditShowForm());
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.edit),
      ),
    );
  }
}
