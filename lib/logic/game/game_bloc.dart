import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unigame/logic/game/game_event.dart';
import 'package:unigame/logic/game/game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameStateLoading()) {
    on<SaveProfile>(_onSaveProfile);
    on<PlayerMove>(_onPlayerMove);
    on<SavePostQuestions>(_onSavePostQuestions);
  }
  static const zdsParams = {"p1": 0.7, "p2": 0.3, "p3": 0.4, "p4": 0.6};

  static const payoffMatrix = {
    "C": {
      "C": [3, 3],
      "D": [0, 5]
    },
    "D": {
      "C": [5, 0],
      "D": [1, 1]
    }
  };

  /// Maximale Rundenanzahl
  static const maxRounds = 10;

  void _onSaveProfile(SaveProfile event, Emitter<GameState> emit) {
    if (state is GameStateLoaded) {
      final currentState = state as GameStateLoaded;

      emit(
        GameStateLoaded(
          currentRound: currentState.currentRound,
          profile: event.profile,
          history: [],
          cpuScore: 0,
          isLoading: false,
          playerScore: 0,
          hasGameEnded: false,
        ),
      );
      return;
    }

    emit(GameStateLoaded(
      currentRound: 1,
      profile: event.profile,
      history: [],
      cpuScore: 0,
      playerScore: 0,
      isLoading: false,
      hasGameEnded: false,
    ));
  }

  Future<void> _onPlayerMove(PlayerMove event, Emitter<GameState> emit) async {
    Random random = Random();
    final currentState = (state as GameStateLoaded);
    int humanScore = currentState.playerScore;
    int computerScore = currentState.cpuScore;
    List<List<dynamic>> localHistory = currentState.history;

    final currentRound = currentState.currentRound;

    if (currentState.isLoading) {
      return;
    }

    if (currentRound == 0) {
      // Bei Runde 0 einfach OK anzeigen und keine Punkte vergeben
      //emit(currentState);
      print('No Round');
      emit(currentState.copyWith(currentRound: currentRound + 1));
      return;
    } else {
      emit(currentState.copyWith(isLoading: true));
      int timeoutMillis = Random().nextInt(1500);

      await Future.delayed(Duration(milliseconds: timeoutMillis));
      // Computerentscheidung basierend auf ZDS
      String computerChoice;
      if (currentRound == 1) {
        computerChoice = "C"; // Startet kooperativ
      } else {
        String lastHumanChoice =
            localHistory.last[0]; // Letzte Wahl des Menschen
        if (lastHumanChoice == "C") {
          computerChoice = random.nextDouble() < zdsParams["p1"]! ? "C" : "D";
        } else {
          computerChoice = random.nextDouble() < zdsParams["p3"]! ? "C" : "D";
        }
      }
      print('Computer Choice: $computerChoice');

      // Ergebnisse berechnen
      var roundScore = payoffMatrix[event.decision]?[computerChoice];
      if (roundScore != null) {
        humanScore += roundScore[0];
        computerScore += roundScore[1];
        localHistory.add([event.decision, computerChoice, roundScore]);
      }

      print('roundscore: $roundScore');

      // Ergebnisse der vorherigen Runde anzeigen
      if (currentRound > 0) {
        var prevRound = currentRound;
        var prevHumanChoice = localHistory.last[0];
        var prevComputerChoice = localHistory.last[1];
        var prevScores = localHistory.last[2];
        emit(
          currentState.copyWith(
            history: localHistory,
            prevCpuChoice: prevComputerChoice,
            prevHumanChoice: prevHumanChoice,
            cpuScore: computerScore,
            playerScore: humanScore,
            currentRound: currentRound + 1,
            prevScores: prevScores,
            isLoading: false,
            hasGameEnded: currentRound >= maxRounds,
          ),
        );
        print(
          "Runde $prevRound: GESMAT: $roundScore "
          "Runde $prevRound: Sie = $prevHumanChoice, Spieler 2 = $prevComputerChoice, "
          "Punkte: Sie = ${prevScores[0]}, Spieler 2 = ${prevScores[1]}",
        );
      } else {
        emit(currentState.copyWith(
          history: localHistory,
          currentRound: currentRound + 1,
          cpuScore: computerScore,
          isLoading: false,
          playerScore: humanScore,
        ));
      }
    }
  }

  void _onSavePostQuestions(SavePostQuestions event, Emitter<GameState> emit) {
    if (state is GameStateLoaded) {
      final currentState = state as GameStateLoaded;

      emit(currentState.copyWith(postQuestions: event.postQuestions));
    }
  }
}
