import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:what_next/src/models/review.dart';
import 'package:what_next/src/views/review/show_widget.dart';
import 'package:get/get.dart';

void main() {
  late final Review review;
  group('Show Widget', () {
    setUp(() {
      review = Review(
          title: 'title',
          posterPath: '/bhY62Dw8iW54DIhxPQerbuB9DOP.jpg',
          year: 1999,
          genreIds: [1, 3],
          comment: 'comment',
          logo: 'logo',
          rating: 4.0,
          service: 'service',
          user: 'user',
          when: Timestamp.now(),
          movieId: 'movieId');
    });
    testWidgets('does it load and respond to taps?',
        (WidgetTester tester) async {
      // https://luksza.org/2020/testing-flutter-callbacks/
      final completer = Completer<void>();

      // pump the widget with mock http images
      await mockNetworkImagesFor(() => tester.pumpWidget(MaterialApp(
          home: ShowWidget(review: review, onTap: completer.complete))));

      // tap the widget
      await tester.tap(find.byType(InkWell));

      expect(completer.isCompleted, isTrue);
    });
  });
}
