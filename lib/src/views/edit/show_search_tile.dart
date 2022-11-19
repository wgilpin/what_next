import 'package:flutter/material.dart';

import '../../models/show.dart';

class ShowSearchTile extends StatelessWidget {
  const ShowSearchTile({super.key, required this.movie, required this.onTap});

  final Show movie;
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
