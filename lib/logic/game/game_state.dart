// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:shadow_deals/logic/game/models/post_questions_model.dart';

import 'package:shadow_deals/logic/game/models/profile_model.dart';

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
  final bool hasGameEnded;
  final PostQuestionsModel? postQuestions;
  final String usedStrategy;

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
    required this.hasGameEnded,
    this.postQuestions,
    required this.usedStrategy,
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
        hasGameEnded,
        postQuestions,
        usedStrategy,
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
    List<int>? prevScores,
    bool? hasGameEnded,
    PostQuestionsModel? postQuestions,
    String? usedStrategy,
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
        hasGameEnded: hasGameEnded ?? this.hasGameEnded,
        postQuestions: postQuestions ?? this.postQuestions,
        usedStrategy: usedStrategy ?? this.usedStrategy,
      );

  @override
  String toString() =>
      'GameStateLoaded { currentRound: $currentRound | history: ${history.length} | CPU Score: $cpuScore | Player Score: $playerScore | Used Strategy: $usedStrategy}';
}
