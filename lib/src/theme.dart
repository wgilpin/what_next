import 'package:flutter/material.dart';

ThemeData makeTheme() {
  return ThemeData(
    primarySwatch: Colors.blue,
    // Define the default brightness and colors.
    brightness: Brightness.dark,
    // scaffoldBackgroundColor: Colors.grey[200],

    // Define the default font family.
    fontFamily: 'Georgia',

    // Define the default `TextTheme`. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: const TextTheme(
      headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      headline4: TextStyle(fontSize: 24.0, fontStyle: FontStyle.italic),
      bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ),
  );
}
