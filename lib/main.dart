import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:what_next/src/controllers/bindings/auth_binding.dart';
import 'package:what_next/src/theme.dart';
import 'package:what_next/src/utils/root.dart';
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
        scrollBehavior: MyCustomScrollBehavior(),
        home: Root());
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
