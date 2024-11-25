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
    if ((state.prevCpuChoice != null && state.prevCpuChoice != null) &&
        (state.prevScores != null && state.prevScores!.isNotEmpty) &&
        !state.isLoading) {
      SchedulerBinding.instance.addPostFrameCallback(
        (_) {
          showDialog(
            context: context,
            builder: (innerContext) {
              Future.delayed(Duration(milliseconds: 2500), () {
                if (Navigator.canPop(context)) Navigator.of(context).pop(true);
              });
              return AlertDialog(
                title: Center(child: Text('Runde: ${state.currentRound}')),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.prevCpuChoice == 'C'
                        ? 'Der Gegner hat kooperiert'
                        : 'Der Gegner hat Defektiert'),
                    Text(
                        'Punkte: Sie = ${state.prevScores![0]} / Gegner = ${state.prevScores![1]}')
                  ],
                ),
              );
            },
          );
        },
      );
    }
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: 42),
          Text(
            'Willkommen zum Bachelor Game!',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            '''Hier geht es um Deals, Täuschung und das richtige Timing. 
Kannst du das Spiel meistern und als Gewinner hervorgehen, oder wirst du zum Opfer eines Betrugs, der dich alles kostet?

''',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
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
                  Text('Punkte: ${state.playerScore}'),
                  SizedBox(height: 24),
                  Image.asset(
                    // TODO: add image
                    'assets/images/obelisk.jpg',
                    fit: BoxFit.contain,
                    height: 350,
                    width: 275,
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: state.isLoading
                            ? null
                            : () => BlocProvider.of<GameBloc>(context).add(
                                  PlayerMove(decision: 'C'),
                                ),
                        child: Text('Kooperieren'),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: state.isLoading
                            ? null
                            : () => BlocProvider.of<GameBloc>(context).add(
                                  PlayerMove(decision: 'D'),
                                ),
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
                  // TODO: Make dynamic
                  Text('Punkte: ${state.cpuScore}'),
                  SizedBox(height: 24),
                  // TODO: add image
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
          if ((state.prevCpuChoice != null && state.prevCpuChoice != null) &&
              (state.prevScores != null && state.prevScores!.isNotEmpty) &&
              !state.isLoading) ...[
            Text('Ergebnis der letzten Runde:'),
            Text(state.prevCpuChoice == 'C'
                ? 'Der Gegner hat kooperiert'
                : 'Der Gegner hat Defektiert'),
            Text(
                'Punkte: Sie = ${state.prevScores![0]} / Gegner = ${state.prevScores![1]}')
          ],
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
