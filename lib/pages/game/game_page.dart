import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unigame/logic/game/game_bloc.dart';
import 'package:unigame/logic/game/game_event.dart';
import 'package:unigame/logic/game/game_state.dart';
import 'package:unigame/logic/game/models/profile_model.dart';
import 'package:unigame/pages/game/animated_button_row.dart';
import 'package:unigame/pages/game/profile_dialog.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  Widget _buildBody(BuildContext context, GameStateLoaded state) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: 84),
          Text(
            '''Hallo ${state.profile?.name},
               Ziel des Spielst ist es: Lorem ipsum dolor sit amet, consetetur sadipscing elitr,
                sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, 
                
              ''',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          Text(
            'Runde: ${state.currentRound}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    '${state.profile?.name}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text('Punkte: 3'),
                  SizedBox(height: 24),
                  Image.asset(
                    'assets/images/obelisk.jpg',
                    fit: BoxFit.contain,
                    height: 350,
                    width: 275,
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () => print('lala'),
                        child: Text('Kooperieren'),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => print('lulu'),
                        child: Text('Defektieren'),
                      ),
                    ],
                  )
                ],
              ),
              Text(
                'VS',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Column(
                children: [
                  Text(
                    'Joffrey',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text('Punkte: 0'),
                  SizedBox(height: 24),
                  Image.asset(
                    'assets/images/joffrey.jpg',
                    fit: BoxFit.contain,
                    height: 350,
                    width: 275,
                  ),
                  SizedBox(height: 12),
                  AnimatedButtonsRow(),
                ],
              ),
            ],
          ),
          SizedBox(height: 24),
          Text('Hier kann noch irgenein Text stehen'),
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
              BlocProvider.of<GameBloc>(context).add(
                SaveProfile(
                  profile: ProfileModel(
                    name: 'Obelisk der Peiniger',
                    age: 72,
                    salutation: 'M',
                    yearsOfExperience: 58,
                    jobTitle: 'Peinigen',
                  ),
                ),
              );
            });
            // TODO: uncomment when game goes life
            //   SchedulerBinding.instance.addPostFrameCallback(
            //     (_) {
            //       showDialog(
            //         context: context,
            //         builder: (innerContext) {
            //           return ProfileDialog(
            //             gameBloc: BlocProvider.of<GameBloc>(context),
            //           );
            //         },
            //       );
            //     },
            //   );
            return Center(
              child: Text(
                'Du hast dein Profil nicht gespeichert, bitte lade die Seite neu.',
              ),
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
