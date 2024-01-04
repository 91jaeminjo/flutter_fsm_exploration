import 'package:automata/automata.dart';
import 'package:stream_transform/stream_transform.dart';

import 'game_session_tokens.dart';

class SkullKingState {
  late final StateMachine appFsm;
  late final Stream<GameState> stateStream;
  SkullKingState() {
    appFsm = _appStateMachineSetup();
    stateStream = appFsm.stream
        .map(
          (event) => GameState(event.activeNodes.last.stateType, session),
        )
        .startWith(GameState(Home, session));
  }

  final List<GameSessionToken> _sessionHistory = [];
  GameSessionToken get session =>
      _sessionHistory.isEmpty ? GameSessionToken([]) : _sessionHistory.last;

  StateMachine _appStateMachineSetup() => StateMachine.create(
        id: 'skull_king_fsm',
        (g) => g
          ..initial<Home>()
          ..state<Home>(
            builder: (g) => g
              ..onEntry((_) {
                // disable wakelock
              })
              ..on<StartNewGame, InitGame>(actions: [
                //wake lock
                (_) => _sessionHistory.clear(),
              ])
              ..on<ViewGameHistory, History>(),
          )
          ..state<InitGame>(
            builder: (g) => g
              ..onEntry((_) {})
              ..on<InitGameFinished, Playing>(actions: [
                (gameSetup) =>
                    _sessionHistory.add(GameSessionToken(gameSetup.players))
              ])
              ..on<Exit, Home>(),
          )
          ..state<Playing>(
            builder: (g) => g
              ..on<GameFinished, Home>()
              ..on<Exit, Home>(),
          )
          ..state<History>(
            builder: (g) => g
              ..onEntry((_) {})
              ..on<Exit, Home>(),
          ),
      );
}

class GameState {
  final Type state;
  final GameSessionToken session;

  const GameState(this.state, this.session);
}

// states

class Home implements AutomataState {}

class InitGame implements AutomataState {}

class Playing implements AutomataState {}

class History implements AutomataState {}

class Prediction implements AutomataState {}

class Result implements AutomataState {}

// events

class StartNewGame implements AutomataEvent {}

class InitGameFinished implements AutomataEvent {
  final List<String> players;
  const InitGameFinished(this.players);
}

class RoundFinished implements AutomataEvent {}

class GameNotFinished implements AutomataEvent {}

class GameFinished implements AutomataEvent {}

class ViewGameHistory implements AutomataEvent {}

class Exit implements AutomataEvent {}
