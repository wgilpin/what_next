import 'package:flutter/material.dart';

typedef RatingChangeCallback = void Function(double rating);

class StarRating extends StatefulWidget {
  final int starCount;
  double rating;
  final RatingChangeCallback? onRatingChanged;
  final Color? color;
  StarRating(
      {super.key,
      this.starCount = 5,
      this.rating = 0.0,
      this.onRatingChanged,
      this.color});

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= widget.rating) {
      icon = Icon(
        Icons.star_border,
        color: Theme.of(context).colorScheme.secondary,
      );
    } else if (index > widget.rating - 1 && index < widget.rating) {
      icon = Icon(
        Icons.star_half,
        color: widget.color ?? Theme.of(context).colorScheme.secondary,
      );
    } else {
      icon = Icon(
        Icons.star,
        color: widget.color ?? Theme.of(context).colorScheme.secondary,
      );
    }
    return InkResponse(
      onTap: widget.onRatingChanged == null
          ? null
          : () => setState(() {
                widget.rating = index + 1.0;
                widget.onRatingChanged!(index + 1.0);
              }),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            widget.starCount, (index) => buildStar(context, index)));
  }
}
