// Import the test package and Counter class

import 'package:flutter_test/flutter_test.dart';
import 'package:what_next/src/controllers/my_reviews_controller.dart';

import 'flutter_test_config.dart';

void main() {
  late MyReviewsCtl revCtl;
  group('My Reviews Controller', () {
    setUp(() {
      revCtl = MyReviewsCtl(mockDb);
    });

    test('I can find my reviews', () async {
      var myReview = await revCtl.getMyReview('1');
      expect(myReview, isNotNull);
      expect(myReview?.comment, 'comment1');
      expect(myReview?.posterPath, 'poster1');
      expect(myReview?.user, 'user1');
    });
  });
}
