import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:what_next/src/services/tmdb_api.dart';

import '../models/movie.dart';
import 'movies_exception.dart';

class MovieSearchCtl extends GetxController {
  var searchResults = <Movie>[].obs;
  GenreMap genres = {};

  Future<void> search({required String text}) async {
    try {
      late List<Movie> interimResults = [];

      // get the genre list if not already loaded, and the search results
      await Future.wait([
        if (genres.isEmpty)
          MovieService().getGenres().then((newGenres) => genres = newGenres),
        MovieService()
            .search(text: text)
            .then((result) => interimResults = result),
      ]);

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
