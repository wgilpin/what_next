// from https://github.com/kudpig/flutter_api_json_sample_at_movie/blob/main/lib/home/movie_service.dart

// Packages
import 'package:dio/dio.dart';
import 'package:what_next/src/apis/movies_exception.dart';
// Models
import 'movie.dart';


class MovieService {
  final Dio _dio = Dio();

  static const String _apiKey = 'f677412008f378e0d65efdb2e542aa1f';

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
}
