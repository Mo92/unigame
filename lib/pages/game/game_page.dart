import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unigame/logic/game/game_bloc.dart';
import 'package:unigame/logic/game/game_state.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  Widget _buildBody(BuildContext context) {
    return const Center();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // TODO: Page Title
        title: const Text('Lets Gamble'),
      ),
      body: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          return _buildBody(context);
        },
      ),
    );
  }
}
