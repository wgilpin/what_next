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
    return Movie(
      title: map['title'] ?? '',
      posterPath: map['poster_path'] ?? '',
      year: int.tryParse(map['release_date'].substring(0, 4)) ?? 0,
    );
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
