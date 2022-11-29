// Import the test package and Counter class

import 'package:flutter_test/flutter_test.dart';
import 'package:what_next/src/controllers/genre_controller.dart';

import 'mock_dio.dart';

void main() {
  late GenreCtl controller;
  final mockDio = MockDio();
  group('My Reviews Controller', () {
    setUp(() {
      controller = GenreCtl(mockDio);
    });

    test('genres loaded correctly', () async {
      var genreList = await controller.getGenres();
      expect(genreList, isNotNull);
      expect(genreList, hasLength(19));
      expect(genreList[878], 'Science Fiction');
      expect(genreList[10751], 'Family');
    });
  });
}
