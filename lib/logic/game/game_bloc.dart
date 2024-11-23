import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unigame/logic/game/game_event.dart';
import 'package:unigame/logic/game/game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameStateLoading()) {
    on<SaveProfile>(_onSaveProfile);
  }

  void _onSaveProfile(SaveProfile event, Emitter<GameState> emit) {
    if (state is GameStateLoaded) {
      final currentState = state as GameStateLoaded;

      emit(
        GameStateLoaded(
            currentRound: currentState.currentRound, profile: event.profile),
      );
      return;
    }

    emit(GameStateLoaded(currentRound: 0, profile: event.profile));
  }
}
