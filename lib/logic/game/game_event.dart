import 'package:equatable/equatable.dart';
import 'package:unigame/logic/game/models/profile_model.dart';

abstract class GameEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SaveProfile extends GameEvent {
  final ProfileModel profile;

  SaveProfile({required this.profile});

  @override
  List<Object> get props => [profile];
}

class StartGame extends GameEvent {}

class PlayerMove extends GameEvent {
  final String decision;

  PlayerMove({required this.decision});

  @override
  List<Object> get props => [decision];
}

class RoundEnd extends GameEvent {
  final int roundCounter;

  RoundEnd({required this.roundCounter});

  @override
  List<Object> get props => [roundCounter];
}

class NextRound extends GameEvent {}

class GameEnd extends GameEvent {}
