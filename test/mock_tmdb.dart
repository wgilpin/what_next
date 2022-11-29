import 'package:mocktail/mocktail.dart';
import 'package:what_next/src/services/tmdb_api.dart';

class MockTmdb extends Mock implements TmdbService {
  final GenreMap genres = {
    28: 'Action',
    12: 'Adventure',
    16: 'Animation',
    35: 'Comedy',
    80: 'Crime',
    99: 'Documentary',
    18: 'Drama',
    10751: 'Family',
    14: 'Fantasy',
    36: 'History',
    27: 'Horror',
    10402: 'Music',
    9648: 'Mystery',
    10749: 'Romance',
    878: 'Science Fiction',
    10770: 'TV Movie',
    53: 'Thriller',
    10752: 'War',
    37: 'Western',
  };

  @override
  Future<GenreMap> getGenres() {
    return Future.value(genres);
  }

  int genreIdAt(int index) {
    return genres.keys.elementAt(index);
  }

  String genreNameAt(int index) {
    return genres.values.elementAt(index);
  }
}
