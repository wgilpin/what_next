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
  String movieId = '';

  Review({
    required String title,
    required String posterPath,
    required int year,
    required List<int> genreIds,
    required this.comment,
    required this.logo,
    required this.rating,
    required this.service,
    required this.user,
    required this.when,
    required this.movieId,
  }) : super(
            title: title,
            posterPath: posterPath,
            year: year,
            id: movieId,
            genreIds: genreIds);

  Review.fromMovie(Movie movie)
      : super(
            title: movie.title,
            posterPath: movie.posterPath,
            year: movie.year,
            id: movie.id,
            genreIds: movie.genreIds) {
    title = movie.title;
    posterPath = movie.posterPath;
    year = movie.year;
    logo = '';
    rating = 0.0;
    service = '';
    comment = '';
    user = FirebaseAuth.instance.currentUser?.uid ?? '';
    when = Timestamp.now();
    movieId = id;
    genreIds = genreIds;
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
      'movie_id': movieId,
      'year': year,
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
      movieId: map['movie_id'] ?? '',
      genreIds: map['genre_ids'] ?? [],
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) => Review.fromMap(json.decode(source));

  static Review fromSnapshot(DocumentSnapshot snapshot) {
    var map = snapshot.data() as Map<String, dynamic>;
    var review = Review(
      title: map['title'] ?? '',
      posterPath: map['poster_path'] ?? '',
      year: map['year'] ?? 0,
      logo: map['logo'] ?? '',
      rating: map['rating'].toDouble(),
      service: map['service'] ?? '',
      user: map['user'],
      when: map['when'],
      comment: map['comment'] ?? '',
      movieId: map['movie_id'],
      genreIds: map['genre_ids'] ?? [],
    );
    return review;
  }
}
