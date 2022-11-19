import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:what_next/src/services/tmdb_api.dart';

import '../models/show.dart';
import 'show_exception.dart';

typedef GenreMap = Map<int, String>;

class GenreCtl extends GetxController {
  var genres = GenreMap().obs;

  // get the genre list from TMDB
  Future<GenreMap> getGenres() async {
    await TmdbService()
        .getGenres()
        .then((newGenres) => genres.value = newGenres);
    return genres;
  }
}
