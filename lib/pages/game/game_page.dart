import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadow_deals/core/helpers.dart';
import 'package:shadow_deals/logic/game/game_bloc.dart';
import 'package:shadow_deals/logic/game/game_event.dart';
import 'package:shadow_deals/logic/game/game_state.dart';
import 'package:shadow_deals/pages/game/widgets/animated_button_row.dart';
import 'package:shadow_deals/pages/game/post_game_dialog.dart';
import 'package:shadow_deals/pages/game/profile_dialog.dart';
import 'package:shadow_deals/pages/shared/markdown_page.dart';
import 'package:shadow_deals/pages/shared/page.dart';

class GamePage extends StatelessWidget {
  const GamePage({
    super.key,
    required this.usePlayerTerm,
  });

  final bool usePlayerTerm;

  Widget _buildBody(BuildContext context, GameStateLoaded state) {
    if ((state.prevCpuChoice != null && state.prevCpuChoice != null) &&
        (state.prevScores != null && state.prevScores!.isNotEmpty) &&
        !state.isLoading &&
        state.postQuestions == null) {
      SchedulerBinding.instance.addPostFrameCallback(
        (_) {
          showDialog(
            context: context,
            builder: (innerContext) {
              Future.delayed(Duration(milliseconds: 2000), () {
                // ignore: use_build_context_synchronously
                if (Navigator.canPop(context)) Navigator.of(context).pop(true);
              });
              return AlertDialog(
                title: Center(child: Text('Runde: ${state.currentRound - 1}')),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(defectOrCoop(state.prevCpuChoice!, extended: true)),
                    Text(
                        'Punkte: Du = ${state.prevScores![0]} / Dealer = ${state.prevScores![1]}')
                  ],
                ),
              );
            },
          );
        },
      );
    }
    if (state.profile != null && state.currentRound == 1 && !state.isLoading) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Future.delayed(Duration(milliseconds: 4000), () {
          // ignore: use_build_context_synchronously
          if (Navigator.canPop(context)) Navigator.of(context).pop(true);
        });
        showDialog(
            context: context,
            builder: (innerContext) {
              return Dialog.fullscreen(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Ein Dealer wird gesucht...'),
                      SizedBox(height: 24),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              );
            });
      });
    }
    if (state.hasGameEnded && state.postQuestions == null) {
      return PostGameDialog(gameBloc: BlocProvider.of<GameBloc>(context));
    }
    if (state.hasGameEnded && state.postQuestions != null) {
      return Center(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Vielen Dank für deine Teilnahme',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center),
              SizedBox(height: 12),
              if (state.playerScore > state.cpuScore ||
                  state.playerScore == state.cpuScore)
                Text(
                    'Du beherrschst den Untergrundmarkt wie kein anderer! Deine Deals sind präzise und extrem profitabel – du weißt genau, wie man jede Gelegenheit zu deinem Vorteil nutzt. Setze deine Taktik fort und steigere deine Gewinne weiter, bis dir der Markt gehört.'),
              if (state.playerScore < state.cpuScore)
                Text(
                    'Deine Shadow Deals zeigen noch Luft nach oben. In den Tiefen des Untergrundmarktes zählt nur eines: präzise Entscheidungen und maximale Profite. Feile an deiner Strategie, finde lukrativere Deals und bringe dein Geschäft auf die nächste Stufe.'),
              SizedBox(height: 12),
              Text(
                  'Gesamtergebnis: Du: ${state.playerScore} / Dealer: ${state.cpuScore}'),
              SizedBox(height: 12),
              Text('Ergebnisse der jeweiligen Runden'),
              SizedBox(height: 12),
              ..._buildScores(context, state),
            ],
          ),
        )),
      );
    }
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: 42),
          Text(
            'Willkommen in der Unterwelt!',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            '''Hier geht es um Deals, Täuschung und das richtige Timing. 
Kannst du das Spiel meistern und als erfolgreicher Dealer hervorgehen, oder wirst du zum Opfer eines Betrugs, der dich alles kostet?
''',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Text(
            'Runde: ${state.currentRound}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(height: 24),
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
                    'assets/images/player.png',
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
                        child: Text('Ehrlich handeln'),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: state.isLoading
                            ? null
                            : () => BlocProvider.of<GameBloc>(context).add(
                                  PlayerMove(decision: 'D'),
                                ),
                        child: Text('Betrügen'),
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
                    state.usedStrategy,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(''),
                  SizedBox(height: 24),
                  Image.asset(
                    /// Extrahiert den zweiten Teil des Namens der Strategie und sucht nach einem Bild
                    /// das genau so heißt. Bsp.: Wennd die Strategie `Zen Dominator` heißt, würde der Pfad
                    /// so aussehen: `assets/images/dominator.png`
                    /// ! Der Name wird klein geschrieben !
                    /// ! Es muss eine PNG Datei sein !
                    'assets/images/${state.usedStrategy.split(' ').last.toLowerCase()}.png',
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
            Text(defectOrCoop(state.prevCpuChoice!, extended: true)),
            Text(
                'Punkte: Du = ${state.prevScores![0]} / Dealer = ${state.prevScores![1]}')
          ],
        ],
      ),
    );
  }

  List<Widget> _buildScores(BuildContext context, GameStateLoaded state) {
    final List<Widget> rows = [];
    int roundCount = -1;

    for (final round in state.history) {
      roundCount = roundCount + 1;
      final hChoice = round[0];
      final cChoice = round[1];
      final scores = round[2];

      rows.add(
        Center(
          child: Row(
            children: [
              Text('Runde ${roundCount + 1}:'),
              SizedBox(width: 4),
              Text(
                  'Du = ${defectOrCoop(hChoice)}, Dealer =  ${defectOrCoop(cChoice)}'),
              SizedBox(width: 4),
              Text('Punkte: Du = ${scores[0]}, Dealer= ${scores[1]}'),
              SizedBox(width: 12),
            ],
          ),
        ),
      );
    }

    return rows;
  }

  void routeToMarkdownPages(BuildContext context, bool isImprint) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MarkdownPage(isImprint: isImprint),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Shadow Deals'),
      ),
      persistentFooterButtons: [
        TextButton(
          onPressed: () => routeToMarkdownPages(context, true),
          child: Text('Impressum'),
        ),
        TextButton(
          onPressed: () => routeToMarkdownPages(context, false),
          child: Text('Datenschutzerklärung'),
        )
      ],
      persistentFooterAlignment: AlignmentDirectional.centerEnd,
      child: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          if (state is GameStateLoading) {
            SchedulerBinding.instance.addPostFrameCallback(
              (_) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (innerContext) {
                    return ProfileDialog(
                      gameBloc: BlocProvider.of<GameBloc>(context),
                      usePlayerTerm: usePlayerTerm,
                    );
                  },
                );
              },
            );
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
