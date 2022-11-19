import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:what_next/src/services/tmdb_api.dart';

import '../models/movie.dart';
import 'movies_exception.dart';

typedef GenreMap = Map<int, String>;

class GenreCtl extends GetxController {
  var genres = GenreMap().obs;

  // get the genre list from TMDB
  Future<GenreMap> getGenres() async {
    await MovieService()
        .getGenres()
        .then((newGenres) => genres.value = newGenres);
    return genres;
  }
}
