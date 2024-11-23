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

  GameStateLoaded({
    required this.currentRound,
    this.profile,
    this.profileSafed,
  });

  @override
  List<Object?> get props => [currentRound, profile, profileSafed];
}
