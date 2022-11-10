import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// https://github.com/kudpig/flutter_api_json_sample_at_movie/blob/main/lib/home/movie.dart

class Movie {
  String title;
  String posterPath;
  int year;

  Movie({
    required this.title,
    required this.posterPath,
    required this.year,
  });

  String get fullImageUrl => 'https://image.tmdb.org/t/p/w200$posterPath';

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'poster_path': posterPath,
      'release_date': year,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    int year = 0;
    if (map.containsKey('release_date')) {
      try {
        year = map['release_date'].toString().length >= 4
            ? int.parse(map['release_date'].toString().substring(0, 4))
            : 0;
      } on Exception {
        print('Year Exception $map');
        year = 0;
      }
    }
    var res = Movie(
      title: map['title'] ?? '',
      posterPath: map['poster_path'] ?? '',
      year: year,
    );
    return res;
  }

  String toJson() => json.encode(toMap());

  factory Movie.fromJson(String source) => Movie.fromMap(json.decode(source));

  static Movie fromSnapshot(DocumentSnapshot snapshot) {
    return Movie(
      title: snapshot['title'] ?? '',
      posterPath: snapshot['poster_path'] ?? '',
      year: int.tryParse(snapshot['release_date'].substring(0, 4)) ?? 0,
    );
  }
}
