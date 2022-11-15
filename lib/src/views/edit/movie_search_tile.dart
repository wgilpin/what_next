import 'package:flutter/material.dart';

import '../../models/movie.dart';

class MovieSearchTile extends StatelessWidget {
  const MovieSearchTile({super.key, required this.movie, required this.onTap});

  final Movie movie;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(movie.title),
      subtitle: Text(movie.year.toString()),
      trailing:
          GestureDetector(onTap: onTap, child: const Icon(Icons.chevron_right)),
    );
  }
}
