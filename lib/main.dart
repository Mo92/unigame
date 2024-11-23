import 'package:flutter/material.dart';
import 'package:unigame/pages/landing_page.dart';

void main() {
  runApp(const UniGame());
}

class UniGame extends StatelessWidget {
  const UniGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uni Game ZDS',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LandingPage(),
    );
  }
}
