import 'package:flutter/material.dart';

class TextEdit extends StatelessWidget {
  const TextEdit({super.key, required this.label, this.onChanged, this.textRequired = false});

  final String label;
  final bool textRequired;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // The validator receives the text that the user has entered.
      validator: textRequired
          ? (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            }
          : null,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        labelText: label,
      ),
    );
  }
}
