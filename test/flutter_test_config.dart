import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:what_next/src/controllers/auth_controller.dart';

import 'mock_auth_ctl.dart';

FakeFirebaseFirestore? mockDb;

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  mockDb ??= FakeFirebaseFirestore();

  setUp(() async {
    debugPrint('test setUp');

    Get.testMode = true;
    // fake movies
    const movies = [
      {
        'title': 'movie1',
        'poster_path': 'poster1',
        'genre_ids': [1, 2, 3],
      },
      {
        'title': 'movie2',
        'poster_path': 'poster2',
        'genre_ids': [4],
      },
      {
        'title': 'movie3',
        'poster_path': 'poster3',
        'genre_ids': [5, 6],
      },
    ];

    var reviews = {
      '1': [
        {
          'comment': 'comment1',
          'genre_ids': [1, 2, 3],
          'movie_id': '1',
          'poster_path': 'poster1',
          'rating': 3,
          'servie': 'netflix',
          'title': 'movie1',
          'user': 'user1',
          'when': Timestamp.fromDate(DateTime(2021, 1, 1)),
          'visible_to': ['user1'],
          'year': 2021,
        },
        {
          'comment': 'comment2',
          'genre_ids': [1, 2, 3],
          'movie_id': '1',
          'poster_path': 'poster12',
          'rating': 5,
          'servie': 'amazon',
          'title': 'movie1',
          'user': 'user2',
          'when': Timestamp.fromDate(DateTime(2021, 1, 1)),
          'visible_to': ['user1', 'user2'],
          'year': 2022,
        },
      ],
    };

    for (int i = 0; i < movies.length; i++) {
      // movie ids from 1
      await mockDb!.collection('movies').doc((i + 1).toString()).set(movies[i]);
    }
    for (var review in reviews.entries) {
      for (var reviewData in review.value) {
        await mockDb!
            .collection('movies')
            .doc(review.key)
            .collection('reviews')
            .add(reviewData);
      }
    }

    // debugPrint(mockDb!.dump());

    // ignore: unnecessary_cast
    Get.put(MockAuthCtl(MockFirebaseAuth()) as AuthCtl);
  });

  tearDown(() {});

  await testMain();
}
