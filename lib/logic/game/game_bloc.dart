import 'dart:async';
import 'dart:math';
import 'dart:developer' as dev;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadow_deals/logic/game/data/game_repository.dart';
import 'package:shadow_deals/logic/game/game_event.dart';
import 'package:shadow_deals/logic/game/game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameStateLoading()) {
    on<SaveProfile>(_onSaveProfile);
    on<PlayerMove>(_onPlayerMove);
    on<SavePostQuestions>(_onSavePostQuestions);
    on<UploadResults>(_uploadResults);
  }

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

  /// Hier die Liste erweitern für die Strategien
  /// ['Zen Dominator', 'Den Zominator'] <- das wären
  /// Zwei Strategien
  List<String> strategies = ['Zen Dominator'];

  /// Maximale Rundenanzahl (wert ist egal, da es neu zugewiesen wird)
  int maxRounds = 4;

  /// Die grenze für das zufällige ende
  int maxRoundsScope = 22;

  /// Die mindestanzahl der Runden für das zufällige ende
  int minRoundsScope = 18;

  Future<void> _onSaveProfile(
      SaveProfile event, Emitter<GameState> emit) async {
    // sucht sich eine zufällige strategie aus
    final selectedStrategy = strategies[Random().nextInt(strategies.length)];

    /// Wählt eine zufällige Zahl zwischen der Differenz von `minRoundsScope`
    /// und `maxRoundsScope`, daraufhin wird die Mindestanforderung addiert.
    /// Das Ergebnis ist die Anzahl der Gesamtrunden.
    maxRounds =
        Random().nextInt(maxRoundsScope - minRoundsScope) + minRoundsScope;

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
          usedStrategy: selectedStrategy,
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
      usedStrategy: selectedStrategy,
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
      emit(currentState.copyWith(currentRound: currentRound + 1));
      return;
    } else {
      emit(currentState.copyWith(isLoading: true));
      int timeoutMillis = Random().nextInt(1500);

      await Future.delayed(Duration(milliseconds: timeoutMillis));
      // Computerentscheidung basierend auf ZDS
      String computerChoice;

      /// Hier wird die ausgewählte Strategie überprüft
      /// Um das zu erweitern, einfach mehr `case` einfügen und break nicht vergessen
      /// Dafür muss eine neue function erstellt werden siehe `zenDominator`
      ///
      /// Bsp:
      ///   case 'Zen Dominator':
      ///      computerChoice = zenDominator(currentRound, localHistory, random);
      ///      break;
      ///   case 'Den Zominator':
      ///      computerChoice = neueMethode(currentRound, localHistory, random);
      ///      break;
      switch (currentState.usedStrategy) {
        case 'Zen Dominator':
          computerChoice = zenDominator(currentRound, localHistory, random);
          break;

        /// case 'Den Zominator':
        ///  computerChoice = neueMethode(currentRound, localHistory, random);
        ///  break;

        /// Die Standard Strategie, falls keine zugeordnet werden kann
        /// (das sollte nicht passieren)
        default:
          computerChoice = zenDominator(currentRound, localHistory, random);
      }

      // Ergebnisse berechnen
      var roundScore = payoffMatrix[event.decision]?[computerChoice];
      if (roundScore != null) {
        humanScore += roundScore[0];
        computerScore += roundScore[1];
        localHistory.add([event.decision, computerChoice, roundScore]);
      }

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
        dev.log(
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

  /// Die erste ZDS Strategie, hier kann man sich für zukünfite Strategien orientieren
  String zenDominator(
      int currentRound, List<List<dynamic>> localHistory, Random random) {
    String computerChoice;
    const zdsParams = {"p1": 0.7, "p2": 0.3, "p3": 0.4, "p4": 0.6};
    if (currentRound == 1) {
      computerChoice = "C"; // Startet kooperativ
    } else {
      String lastHumanChoice = localHistory.last[0]; // Letzte Wahl des Menschen
      if (lastHumanChoice == "C") {
        computerChoice = random.nextDouble() < zdsParams["p1"]! ? "C" : "D";
      } else {
        computerChoice = random.nextDouble() < zdsParams["p3"]! ? "C" : "D";
      }
    }
    return computerChoice;
  }

  /// BEISPIEL:
  /// Eine Strategie die Analog zum Zen Dominator eine invertierte Matrix hat
  // String denZominator(
  //     int currentRound, List<List<dynamic>> localHistory, Random random) {
  //   String computerChoice;
  //   const zdsParams = {"p1": 0.3, "p2": 0.7, "p3": 0.6, "p4": 0.4};
  //   if (currentRound == 1) {
  //     computerChoice = "C"; // Startet kooperativ
  //   } else {
  //     String lastHumanChoice = localHistory.last[0]; // Letzte Wahl des Menschen
  //     if (lastHumanChoice == "C") {
  //       computerChoice = random.nextDouble() < zdsParams["p1"]! ? "C" : "D";
  //     } else {
  //       computerChoice = random.nextDouble() < zdsParams["p3"]! ? "C" : "D";
  //     }
  //   }
  //   return computerChoice;
  // }

  void _onSavePostQuestions(SavePostQuestions event, Emitter<GameState> emit) {
    if (state is GameStateLoaded) {
      final currentState = state as GameStateLoaded;

      emit(currentState.copyWith(postQuestions: event.postQuestions));
    }

    add(UploadResults());
  }

  FutureOr<void> _uploadResults(
      UploadResults event, Emitter<GameState> emit) async {
    if (state is GameStateLoaded) {
      final currentState = state as GameStateLoaded;
      final repo = GameRepository();
      await repo.getDriveApi(
        currentState.profile!,
        currentState.postQuestions!,
        currentState.history,
        currentState.playerScore,
        currentState.cpuScore,
        currentState.usedStrategy,
      );
    }
  }
}
