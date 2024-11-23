import 'package:flutter/material.dart';
import 'package:unigame/pages/game/game_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  Widget _buildBody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'lorem dolar sit amet',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 14),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam',
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 14),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => const GamePage(),
              ),
            ),
            child: const Text('Start Game'),
          ),
          const SizedBox(height: 140),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Uni Games'),
      ),
      body: _buildBody(context),
    );
  }
}
