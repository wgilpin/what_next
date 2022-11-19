// from https://github.com/kudpig/flutter_api_json_sample_at_movie/blob/main/lib/home/movie_service.dart

// Packages
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:what_next/src/controllers/movies_exception.dart';
// Models
import '../models/movie.dart';

typedef GenreMap = Map<int, String>;

class MovieService {
  final Dio _dio = Dio();

  static const String _apiKey = 'f677412008f378e0d65efdb2e542aa1f';

  // searches for the post popular movies
  Future<List<Movie>> getMovies() async {
    try {
      final response = await _dio
          .get("https://api.themoviedb.org/3/movie/popular?api_key=$_apiKey");
      final results = List<Map<String, dynamic>>.from(response.data['results']);
      List<Movie> movies =
          results.map((movieData) => Movie.fromMap(movieData)).toList();
      return movies;
    } on DioError catch (dioError) {
      throw MoviesException.fromDioError(dioError);
    }
  }

  // searchs for [kind] 'movies' or 'shows' by title or part-title
  Future<List<Movie>> _doSearch(String title, String kind) async {
    try {
      final url = "https://api.themoviedb.org/3/search/"
          "$kind?api_key=$_apiKey&query=${Uri.encodeComponent(title)}";
      debugPrint('url: $url');
      final response = await _dio.get(url);
      final results = List<Map<String, dynamic>>.from(response.data['results']);
      List<Movie> movies =
          results.map((movieData) => Movie.fromMap(movieData)).toList();
      debugPrint('$kind ->');
      debugPrint([for (Movie m in movies) m.title].toString());
      return movies;
    } on DioError catch (dioError) {
      throw MoviesException.fromDioError(dioError);
    }
  }

  Future<List<Movie>> search({required String text}) async {
    List<Movie> movies = [];
    List<Movie> shows = [];

    await Future.wait<void>([
      _doSearch(text, 'movie').then((result) => movies = result),
      _doSearch(text, 'tv').then((result) => shows = result),
    ]);
    return [...movies, ...shows];
  }

  // searches for the post popular movies
  Future<GenreMap> getGenres() async {
    try {
      late GenreMap genres = {};
      await Future.wait([
        _dio
            .get(
                "https://api.themoviedb.org/3/genre/movie/list?api_key=$_apiKey")
            .then((response) {
          print('Data: $response.data');
          print('Genres: $response.data.genres');
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
      throw MoviesException.fromDioError(dioError);
    }
  }
}
