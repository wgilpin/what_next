import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:what_next/src/utils/layout.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints(maxWidth: 300),
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              const Text('What Next'),
              addVerticalSpace(20),
              const Text('Version 0.0.1'),
              addVerticalSpace(20),
              const Text('© 2021 W Gilpin'),
              addVerticalSpace(40),
              const Text(
                  'This product uses the TMDB API but is not endorsed or certified by TMDB'),
              addVerticalSpace(20),
              ElevatedButton(
                  onPressed: () => Get.back(), child: const Text('OK')),
            ],
          ),
        ),
      ),
    );
  }
}
