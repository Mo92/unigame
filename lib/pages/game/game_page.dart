import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unigame/logic/game/game_bloc.dart';
import 'package:unigame/logic/game/game_state.dart';
import 'package:unigame/pages/game/profile_dialog.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  Widget _buildBody(BuildContext context, GameStateLoaded state) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              'Hallo ${state.profile?.name}, bist du bereit dein Hab und Gut zu verspielen?'),
          Text('''
                Geschlecht: ${state.profile?.salutation}
                Alter: ${state.profile?.age}
                Beruf: ${state.profile?.jobTitle}
                Seit: ${state.profile?.yearsOfExperience} Jahren
              '''),
        ],
      ),
    );
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
          if (state is GameStateLoading) {
            SchedulerBinding.instance.addPostFrameCallback(
              (_) {
                showDialog(
                  context: context,
                  builder: (innerContext) {
                    return ProfileDialog(
                      gameBloc: BlocProvider.of<GameBloc>(context),
                    );
                  },
                );
              },
            );
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is GameStateLoaded) {
            return _buildBody(context, state);
          }

          return Center(
            child: Text(
              'FEHLER LAN FEHLER',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.red),
            ),
          );
        },
      ),
    );
  }
}
