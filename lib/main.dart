import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadow_deals/core/app_bloc_observer.dart';
import 'package:shadow_deals/pages/landing_page.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(const ShadowDeals());
}

class ShadowDeals extends StatelessWidget {
  const ShadowDeals({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shadow Deals',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LandingPage(),
    );
  }
}
