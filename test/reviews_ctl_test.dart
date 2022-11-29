// Import the test package and Counter class

import 'package:flutter_test/flutter_test.dart';
import 'package:what_next/src/controllers/reviews_controller.dart';

import 'flutter_test_config.dart';

void main() {
  late ReviewsCtl revCtl;
  group('My Reviews Controller', () {
    setUp(() {
      revCtl = ReviewsCtl(mockDb);
    });

    test('Can get reviews for a show', () async {
      var reviews = await revCtl.getReviewsForShow('1');
      expect(reviews, isNotNull);
      expect(reviews, hasLength(2));
      expect(reviews.first.comment, 'comment1');
      expect(reviews.first.posterPath, 'poster1');
      expect(reviews.first.user, 'user1');
    });
  });
}
