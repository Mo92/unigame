// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:unigame/logic/game/models/profile_model.dart';

abstract class GameState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GameStateLoading extends GameState {}

class GameStateLoaded extends GameState {
  final ProfileModel? profile;
  final bool? profileSafed;
  final int currentRound;
  final List<List<dynamic>> history;
  final int playerScore;
  final int cpuScore;
  final String? prevHumanChoice;
  final String? prevCpuChoice;
  final List<int>? prevScores;
  final bool isLoading;

  GameStateLoaded({
    required this.isLoading,
    required this.currentRound,
    this.profile,
    this.profileSafed,
    required this.history,
    required this.cpuScore,
    required this.playerScore,
    this.prevHumanChoice,
    this.prevCpuChoice,
    this.prevScores,
  });

  @override
  List<Object?> get props => [
        isLoading,
        currentRound,
        profile,
        profileSafed,
        history,
        cpuScore,
        playerScore,
        prevCpuChoice,
        prevHumanChoice,
        prevScores,
      ];

  GameStateLoaded copyWith({
    bool? isLoading,
    ProfileModel? profile,
    bool? profileSafed,
    int? currentRound,
    List<List<dynamic>>? history,
    int? playerScore,
    int? cpuScore,
    String? prevHumanChoice,
    String? prevCpuChoice,
    final List<int>? prevScores,
  }) =>
      GameStateLoaded(
        isLoading: isLoading ?? this.isLoading,
        profile: profile ?? this.profile,
        profileSafed: profileSafed ?? this.profileSafed,
        currentRound: currentRound ?? this.currentRound,
        history: history ?? this.history,
        playerScore: playerScore ?? this.playerScore,
        cpuScore: cpuScore ?? this.cpuScore,
        prevHumanChoice: prevHumanChoice ?? this.prevHumanChoice,
        prevCpuChoice: prevCpuChoice ?? this.prevCpuChoice,
        prevScores: prevScores ?? this.prevScores,
      );

  @override
  String toString() {
    return 'GameStateLoaded { currentRound: $currentRound | history: ${history.length} | CPU Score: $cpuScore | Player Score: $playerScore }';
  }
}
