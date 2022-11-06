import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// https://github.com/kudpig/flutter_api_json_sample_at_movie/blob/main/lib/home/movie.dart

class Review {
  String title;
  String posterPath;
  String logo;
  String movie;
  double rating;
  String service;
  String user;
  DateTime when;

  Review({
    required this.title,
    required this.posterPath,
    required this.logo,
    required this.movie,
    required this.rating,
    required this.service,
    required this.user,
    required this.when,
  });

  String get fullImageUrl => 'https://image.tmdb.org/t/p/w200$posterPath';

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'poster_path': posterPath,
      'logo': logo,
      'movie': movie,
      'rating': rating,
      'service': service,
      'user': user,
      'when': when,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      title: map['title'] ?? '',
      posterPath: map['poster_path'] ?? '',
      logo: map['logo'] ?? '',
      movie: map['movie'] ?? '',
      rating: map['rating'],
      service: map['service'] ?? '',
      user: map['user'],
      when: map['when'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) => Review.fromMap(json.decode(source));

  static Review fromSnapshot(DocumentSnapshot snapshot) {
    return Review(
      title: snapshot['title'] ?? '',
      posterPath: snapshot['poster_path'] ?? '',
      logo: snapshot['logo'] ?? '',
      movie: snapshot['movie'] ?? '',
      rating: snapshot['rating'],
      service: snapshot['service'] ?? '',
      user: snapshot['user'],
      when: snapshot['when'],
    );
  }
}
