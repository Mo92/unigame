import 'package:equatable/equatable.dart';
import 'package:shadow_deals/logic/game/models/post_questions_model.dart';
import 'package:shadow_deals/logic/game/models/profile_model.dart';

abstract class GameEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SaveProfile extends GameEvent {
  final ProfileModel profile;
  final bool usePlayerTerm;

  SaveProfile({
    required this.profile,
    required this.usePlayerTerm,
  });

  @override
  List<Object> get props => [profile, usePlayerTerm];
}

class UploadResults extends GameEvent {}

class PlayerMove extends GameEvent {
  final String decision;

  PlayerMove({required this.decision});

  @override
  List<Object> get props => [decision];
}

class SavePostQuestions extends GameEvent {
  final PostQuestionsModel postQuestions;

  SavePostQuestions({required this.postQuestions});

  @override
  List<Object> get props => [postQuestions];
}
