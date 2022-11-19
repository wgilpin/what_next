import 'package:get/get.dart';
import 'package:what_next/src/services/tmdb_api.dart';

typedef GenreMap = Map<int, String>;

class GenreCtl extends GetxController {
  var genres = GenreMap().obs;
  int get genreCount => genres.length;

  // get the genre list from TMDB
  Future<GenreMap> getGenres() async {
    await TmdbService()
        .getGenres()
        .then((newGenres) => genres.value = newGenres);
    return genres;
  }

  int genreIdAt(int index) {
    return genres.keys.elementAt(index);
  }

  String genreNameAt(int index) {
    return genres.values.elementAt(index);
  }

  @override
  void onReady() {
    super.onReady();
    getGenres();
  }
}
