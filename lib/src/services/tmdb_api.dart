// from https://github.com/kudpig/flutter_api_json_sample_at_movie/blob/main/lib/home/movie_service.dart

// Packages
import 'package:dio/dio.dart';
import 'package:what_next/src/controllers/movies_exception.dart';
// Models
import '../models/movie.dart';

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
      print('url: $url');
      final response = await _dio.get(url);
      final results = List<Map<String, dynamic>>.from(response.data['results']);
      List<Movie> movies =
          results.map((movieData) => Movie.fromMap(movieData)).toList();
      print('$kind ->');
      print([for (Movie m in movies) m.title]);
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
}
