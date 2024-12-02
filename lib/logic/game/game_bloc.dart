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
    on<ResetGame>(_onResetGame);
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

  /// Für jede Strategie werden die jeweiligen Wahrscheinlichkeiten definiert
  /// und anschließend bei `calculateCpuChoice()` ausgewählt
  final Map<String, double> shadowParams = {
    "CC": 0.7, // Beide kooperieren
    "CD": 0.1, // Spieler kooperiert, CPU defektiert
    "DC": 0.6, // Spieler defektiert, CPU kooperiert
    "DD": 0.3 // beide defektieren
  };

  final Map<String, double> mindParams = {
    "CC": 0.58, // Beide kooperieren
    "CD": 0.1, // Spieler kooperiert, CPU defektiert
    "DC": 0.3, // Spieler defektiert, CPU kooperiert
    "DD": 0.06 // beide defektieren
  };

  final Map<String, double> dealerParams = {
    "CC": 0.92, // Beide kooperieren
    "CD": 0.28, // Spieler kooperiert, CPU defektiert
    "DC": 0.88, // Spieler defektiert, CPU kooperiert
    "DD": 0.56 // beide defektieren
  };

  /// Hier die Liste erweitern für die Strategien
  /// ['Zen Dominator', 'Zen Namitador'] <- das wären
  /// Zwei Strategien
  List<String> strategies = [
    'Zen Shadow',
    'Zen Mind',
    'Zen Dealer',
  ];

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
    // maxRounds =
    //     Random().nextInt(maxRoundsScope - minRoundsScope) + minRoundsScope;

    emit(
      GameStateLoaded(
        currentRound: 1,
        profile: event.profile,
        history: [],
        cpuScore: 0,
        playerScore: 0,
        isLoading: false,
        hasGameEnded: false,
        usedStrategy: selectedStrategy,
        usePlayerTerm: event.usePlayerTerm,
      ),
    );
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
      String computerChoice = calculateCpuChoice(
        currentRound,
        localHistory,
        random,
        currentState.usedStrategy,
      );

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
          "Runde $prevRound: GESAMT: $roundScore "
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
  String calculateCpuChoice(int currentRound, List<List<dynamic>> localHistory,
      Random random, String usedStrategy) {
    String computerChoice = '';
    late Map<String, double> params;

    /// Zieht sich die Params der jeweiligen Strategie
    switch (usedStrategy) {
      case 'Zen Shadow':
        params = shadowParams;
        break;
      case 'Zen Mind':
        params = mindParams;
        break;
      case 'Zen Dealer':
        params = dealerParams;
        break;
    }

    if (currentRound == 1) {
      computerChoice = "C"; // Startet kooperativ
    } else {
      double randomNumber = (random.nextDouble() * 100).floorToDouble() / 100;
      String lastHumanChoice = localHistory.last[0]; // Letzte Wahl des Menschen
      String lastComputerChoice = localHistory.last[1]; // Letzte Wahl des CPU

      if (lastHumanChoice == "C" && lastComputerChoice == "C") {
        computerChoice = randomNumber < params['CC']! ? 'C' : 'D';
      } else if (lastHumanChoice == 'C' && lastComputerChoice == 'D') {
        computerChoice = randomNumber < params['CD']! ? 'C' : 'D';
      } else if (lastHumanChoice == 'D' && lastComputerChoice == 'C') {
        computerChoice = randomNumber < params['DC']! ? 'C' : 'D';
      } else if (lastHumanChoice == 'D' && lastComputerChoice == 'D') {
        computerChoice = randomNumber < params['DD']! ? 'C' : 'D';
      }
    }

    return computerChoice;
  }

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
        currentState.usePlayerTerm,
      );
    }
  }

  void _onResetGame(ResetGame event, Emitter<GameState> emit) {
    if (state is GameStateLoaded) {
      final currentState = state as GameStateLoaded;
      final gamePlayed = currentState.profile!.gamePlayed == 'Nein'
          ? '1'
          : '${currentState.profile!.gamePlayed} + 1';

      add(
        SaveProfile(
          profile: currentState.profile!.copyWith(gamePlayed: gamePlayed),
          usePlayerTerm: currentState.usePlayerTerm,
        ),
      );
    }
  }
}
