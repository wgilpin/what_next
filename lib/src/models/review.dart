import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:what_next/src/models/movie.dart';
import 'package:what_next/src/views/login/fire_auth.dart';

class Review extends Movie {
  String logo = '';
  double rating = 0.0;
  String service = '';
  String user = '';
  DateTime? when;

  Review({
    required String title,
    required String posterPath,
    required int year,
    required this.logo,
    required this.rating,
    required this.service,
    required this.user,
    required this.when,
  }) : super(title: title, posterPath: posterPath, year: year);

  Review.fromMovie(Movie movie)
      : super(
            title: movie.title,
            posterPath: movie.posterPath,
            year: movie.year) {
    title = movie.title;
    posterPath = movie.posterPath;
    year = movie.year;
    logo = '';
    rating = 0.0;
    service = '';
    user = FirebaseAuth.instance.currentUser?.uid ?? '';
    when = DateTime.now();
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'poster_path': posterPath,
      'logo': logo,
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
      rating: map['rating'],
      service: map['service'] ?? '',
      user: map['user'],
      when: map['when'],
      year: map['year'],
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) => Review.fromMap(json.decode(source));

  static Review fromSnapshot(DocumentSnapshot snapshot) {
    return Review(
      title: snapshot['title'] ?? '',
      posterPath: snapshot['poster_path'] ?? '',
      year: snapshot['year'],
      logo: snapshot['logo'] ?? '',
      rating: snapshot['rating'],
      service: snapshot['service'] ?? '',
      user: snapshot['user'],
      when: snapshot['when'],
    );
  }
}
