import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  const ImageButton(
      {super.key,
      required this.image,
      required this.onTap,
      required this.value,
      required this.size});
  final Function onTap;
  final String image;
  final String value;
  final int size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(value), // Handle your callback.
      splashColor: Colors.brown.withOpacity(0.5),
      child: Ink(
        height: size.toDouble(),
        width: size.toDouble(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}
