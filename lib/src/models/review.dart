import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:what_next/src/models/movie.dart';

class Review extends Movie {
  String logo = '';
  double rating = 0.0;
  String service = '';
  String user = '';
  Timestamp? when;
  String comment = '';

  Review({
    required String title,
    required String posterPath,
    required int year,
    required this.comment,
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
    comment = '';
    user = FirebaseAuth.instance.currentUser?.uid ?? '';
    when = Timestamp.now();
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
      'comment': comment,
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
      comment: map['comment'] ?? '',
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) => Review.fromMap(json.decode(source));

  static Review fromSnapshot(DocumentSnapshot snapshot) {
    var map = snapshot.data() as Map<String, dynamic>;
    return Review(
      title: map['title'] ?? '',
      posterPath: map['poster_path'] ?? '',
      year: map['year'] ?? 0,
      logo: map['logo'] ?? '',
      rating: map['rating'],
      service: map['service'] ?? '',
      user: map['user'],
      when: map['when'],
      comment: map['comment'] ?? '',
    );
  }
}
