import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

// https://github.com/kudpig/flutter_api_json_sample_at_movie/blob/main/lib/home/movie.dart

class Show {
  String title;
  String posterPath;
  int year;
  String id;
  List<int> genreIds;

  Show({
    required this.title,
    required this.posterPath,
    required this.year,
    required this.id,
    required this.genreIds,
  });

  String get fullImageUrl => 'https://image.tmdb.org/t/p/w200$posterPath';
  String get fullImageUrlLarge => 'https://image.tmdb.org/t/p/w400$posterPath';

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'poster_path': posterPath,
      'release_date': year,
      'id': id,
      'genres': genreIds,
    };
  }

  factory Show.fromMap(Map<String, dynamic> map) {
    int year = 0;
    // movie & tv show have different terms for release date
    var dateString = map.containsKey('release_date')
        ? map['release_date']
        : map.containsKey('first_air_date')
            ? map['first_air_date']
            : '';
    // get the year from the date string
    try {
      year = dateString.length >= 4 ? int.parse(dateString.substring(0, 4)) : 0;
    } on Exception {
      debugPrint('Year Exception $map');
      year = 0;
    }
    var res = Show(
      title: map['title'] ?? map['name'] ?? 'Unnamed',
      posterPath: map['poster_path'] ?? '',
      year: year,
      genreIds: List<int>.from(map['genre_ids']),
      id: map['id'].toString(),
    );
    return res;
  }

  String toJson() => json.encode(toMap());

  factory Show.fromJson(String source) => Show.fromMap(json.decode(source));

  static Show fromSnapshot(DocumentSnapshot snapshot) {
    return Show(
      title: snapshot['title'] ?? '',
      posterPath: snapshot['poster_path'] ?? '',
      year: int.tryParse(snapshot['release_date'].substring(0, 4)) ?? 0,
      id: snapshot.id,
      genreIds: snapshot['genre_ids'],
    );
  }
}
