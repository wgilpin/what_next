import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:what_next/src/services/tmdb_api.dart';

import '../models/show.dart';
import 'show_exception.dart';

class ShowSearchCtl extends GetxController {
  var searchResults = <Show>[].obs;
  GenreMap genres = {};

  Future<void> search({required String text}) async {
    try {
      late List<Show> interimResults = [];

      // get the genre list if not already loaded, and the search results
      await Future.wait([
        if (genres.isEmpty)
          TmdbService().getGenres().then((newGenres) => genres = newGenres),
        TmdbService()
            .search(text: text)
            .then((result) => interimResults = result),
      ]);

      // order results by exact match then by year
      List<Show> exactMatches = interimResults
          .where((m) => m.title.toLowerCase() == text.toLowerCase())
          .toList();
      List<Show> otherMatches = interimResults
          .where((m) => m.title.toLowerCase() != text.toLowerCase())
          .toList();
      otherMatches.sort((a, b) => b.year.compareTo(a.year));

      // update getX state
      searchResults.value = exactMatches + otherMatches;
      update();
    } on DioError catch (dioError) {
      throw ShowsException.fromDioError(dioError);
    }
  }
}
