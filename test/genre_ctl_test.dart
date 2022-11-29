// Import the test package and Counter class

import 'package:flutter_test/flutter_test.dart';
import 'package:what_next/src/controllers/genre_controller.dart';

import 'mock_tmdb.dart';

void main() {
  late GenreCtl controller;
  final mockTmdb = MockTmdb();
  group('My Reviews Controller', () {
    setUp(() {
      controller = GenreCtl(mockTmdb);
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
