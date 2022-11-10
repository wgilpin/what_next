import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:what_next/src/controllers/auth_controller.dart';
import 'package:what_next/src/controllers/bindings/auth_binding.dart';
import 'package:what_next/src/utils/root.dart';
import 'package:what_next/src/views/login/login_page.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

/// Requires that a Firestore emulator is running locally.
/// See https://firebase.flutter.dev/docs/firestore/usage#emulator-usage
bool shouldUseFirestoreEmulator = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'What Next',
        initialBinding: AppBindings(),
        theme: makeTheme(),
        home: Root());
  }

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
        bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      ),
    );
  }
}
