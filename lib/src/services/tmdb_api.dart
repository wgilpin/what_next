// from https://github.com/kudpig/flutter_api_json_sample_at_movie/blob/main/lib/home/movie_service.dart

// Packages
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:what_next/src/controllers/show_exception.dart';
// Models
import '../models/show.dart';

typedef GenreMap = Map<int, String>;

class TmdbService {
  final Dio _dio = Dio();

  static const String _apiKey = 'f677412008f378e0d65efdb2e542aa1f';

  // searchs for [kind] 'movies' or 'shows' by title or part-title
  Future<List<Show>> _doSearch(String title, String kind) async {
    try {
      final url = "https://api.themoviedb.org/3/search/"
          "$kind?api_key=$_apiKey&query=${Uri.encodeComponent(title)}";
      debugPrint('url: $url');
      final response = await _dio.get(url);
      final results = List<Map<String, dynamic>>.from(response.data['results']);
      List<Show> shows =
          results.map((movieData) => Show.fromMap(movieData)).toList();
      debugPrint('$kind ->');
      debugPrint([for (Show m in shows) m.title].toString());
      return shows;
    } on DioError catch (dioError) {
      throw ShowsException.fromDioError(dioError);
    }
  }

  Future<List<Show>> search({required String text}) async {
    List<Show> movies = [];
    List<Show> tvShows = [];

    await Future.wait<void>([
      _doSearch(text, 'movie').then((result) => movies = result),
      _doSearch(text, 'tv').then((result) => tvShows = result),
    ]);
    return [...movies, ...tvShows];
  }

  // Get the list of genres for movies and tv shows
  Future<GenreMap> getGenres() async {
    try {
      late GenreMap genres = {};
      await Future.wait([
        _dio
            .get(
                "https://api.themoviedb.org/3/genre/movie/list?api_key=$_apiKey")
            .then((response) {
          for (var map in response.data['genres']) {
            genres[map['id']] = map['name'];
          }
        }),
        _dio
            .get("https://api.themoviedb.org/3/genre/tv/list?api_key=$_apiKey")
            .then((response) {
          for (var map in response.data['genres']) {
            genres[map['id']] = map['name'];
          }
        }),
      ]);
      return genres;
    } on DioError catch (dioError) {
      throw ShowsException.fromDioError(dioError);
    }
  }
}
