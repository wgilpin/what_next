import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:what_next/src/services/tmdb_api.dart';

import '../models/movie.dart';
import 'movies_exception.dart';

class MovieSearchCtl extends GetxController {
  var searchResults = <Movie>[].obs;

  Future<void> search({required String text}) async {
    try {
      final interimResults = await MovieService().search(text: text);

      // order results by exact match then by year
      List<Movie> exactMatches = interimResults
          .where((m) => m.title.toLowerCase() == text.toLowerCase())
          .toList();
      List<Movie> otherMatches = interimResults
          .where((m) => m.title.toLowerCase() != text.toLowerCase())
          .toList();
      otherMatches.sort((a, b) => b.year.compareTo(a.year));

      // update getX state
      searchResults.value = exactMatches + otherMatches;
      update();
    } on DioError catch (dioError) {
      throw MoviesException.fromDioError(dioError);
    }
  }
}
