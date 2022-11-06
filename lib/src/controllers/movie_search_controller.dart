import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../models/movie.dart';
import 'movies_exception.dart';

class MovieSearchController extends GetxController {
  final Dio _dio = Dio();

  var searchResults = <Movie>[].obs;

  static const String _apiKey = 'f677412008f378e0d65efdb2e542aa1f';

  Future<void> search({required String text}) async {
    try {
      final url =
          "https://api.themoviedb.org/3/search/movie?api_key=$_apiKey&query=${Uri.encodeComponent(text)}";
      print('url: $url');
      final response = await _dio.get(url);
      final results = List<Map<String, dynamic>>.from(response.data['results']);
      searchResults.value =
          results.map((movieData) => Movie.fromMap(movieData)).toList();
      print('found ${searchResults.length} movies');
    } on DioError catch (dioError) {
      throw MoviesException.fromDioError(dioError);
    }
  }
}
