// Import the test package and Counter class

import 'package:flutter_test/flutter_test.dart';
import 'package:what_next/src/controllers/show_search_controller.dart';

import 'mock_dio.dart';

void main() {
  late ShowSearchCtl controller;
  final mockDio = MockDio();
  group('TMDB Search', () {
    setUp(() {
      controller = ShowSearchCtl(mockDio);
    });

    test('movies found correctly', () async {
      await controller.search(text: 'lord of the rings');
      expect(controller.searchResults, isNotNull);
      expect(controller.searchResults, hasLength(22));
    });
  });
}
