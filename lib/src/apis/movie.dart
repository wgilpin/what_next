import 'dart:convert';

// https://github.com/kudpig/flutter_api_json_sample_at_movie/blob/main/lib/home/movie.dart

class Movie {
  String title;
  String posterPath;

  Movie({
    required this.title,
    required this.posterPath,
  });

  String get fullImageUrl => 'https://image.tmdb.org/t/p/w200$posterPath';

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'poster_path': posterPath,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['title'] ?? '',
      posterPath: map['poster_path'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Movie.fromJson(String source) => Movie.fromMap(json.decode(source));
}
