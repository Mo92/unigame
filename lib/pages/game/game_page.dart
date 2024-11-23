import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unigame/logic/game/game_bloc.dart';
import 'package:unigame/logic/game/game_event.dart';
import 'package:unigame/logic/game/game_state.dart';
import 'package:unigame/logic/game/models/profile_model.dart';

class GamePage extends StatelessWidget {
  GamePage({super.key});

  final ProfileModel profileDummy = ProfileModel(
    name: 'Testmann',
    age: 23,
    salutation: 'M',
    yearsOfExperience: 6,
    jobTitle: 'Student',
  );

  Widget _buildBody(BuildContext context, GameStateLoaded state) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              'Hallo ${state.profile?.name}, bist du bereit dein Hab und Gut zu verspielen?'),
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
            SchedulerBinding.instance.addPostFrameCallback((_) {
              showDialog(
                  context: context,
                  builder: (innerContext) {
                    return AlertDialog(
                      content: Column(
                        children: [
                          Text('Stell dich ma vor Olem'),
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            BlocProvider.of<GameBloc>(context).add(
                              SaveProfile(profile: profileDummy),
                            );
                          },
                          child: Text('Speichern'),
                        )
                      ],
                    );
                  });
            });
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
