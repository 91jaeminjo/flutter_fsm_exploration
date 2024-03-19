import 'dart:async';

import 'package:automata/automata.dart';
import 'package:path/path.dart';
import 'package:skull_king_scorecard/game_state/database/skull_king_database.dart';
import 'package:skull_king_scorecard/game_state/game_records.dart';
import 'package:stream_transform/stream_transform.dart';

import 'game_session_tokens.dart';

class SkullKingState {
  late final StateMachine appFsm;
  late final StateMachine gameFsm;
  late final Stream<Type> stateStream;

  int get currentRound => _sessionState.currentRound;
  set currentRound(int roundNumber) => _sessionState.currentRound = roundNumber;
  GameState _sessionState = GameState(
    PreGameState,
    GameRecord(
      players: [],
    ),
  );

  final StreamController<GameState> gameStreamController =
      StreamController<GameState>.broadcast();
  SkullKingState() {
    appFsm = _appStateMachineSetup();
    gameFsm = _gameStateMachineSetup();
    stateStream = appFsm.stream
        .map(
          (event) => event.activeNodes.last.stateType,
        )
        .startWith(Home);

    gameFsm.stream.map((event) {
      _sessionState.state = event.activeNodes.last.stateType;
      gameStreamController.add(_sessionState);
    }).listen((event) {});
  }

  Stream<GameState> get gameStream =>
      gameStreamController.stream.startWith(_sessionState
          // GameState(
          //   Prediction,
          //   GameRecord(
          //     players:
          //         .isEmpty ? [] : _sessionState.last.record.players,
          //     roundNumber: _sessionState.last.record.roundNumber,
          //   ),
          // ),
          );

  Map<String, int> playerPrediction = {};
  Map<String, int> playerWins = {};
  Map<String, int> playerBonus = {};

  void recordPlayerPredictions(
      {required String player, required int prediction}) {
    playerPrediction[player] = prediction;
  }

  void recordPlayerWins({required String player, required int wins}) {
    playerWins[player] = wins;
  }

  void startGame() {
    final records = <String, RoundRecord>{};
    currentRound = 1;
    for (final entry in playerPrediction.entries) {
      final player = entry.key;
      final record = RoundRecord(
        roundNumber: currentRound,
        player: player,
        winsPredicted: 0,
        actualWins: 0,
        bonus: 0,
      );
      records[player] = record;
    }
    _sessionState.record.addRecord(records);
    gameFsm.send(StartNewGame());
  }

  void startRound() {
    final records = <String, RoundRecord>{};
    for (final entry in playerPrediction.entries) {
      final player = entry.key;
      final record = RoundRecord(
        roundNumber: currentRound,
        player: player,
        winsPredicted: entry.value,
        actualWins: 0,
        bonus: 0,
      );
      records[player] = record;
    }
    _sessionState.record
        .modifyRecord(roundNumber: currentRound - 1, record: records);
    gameFsm.send(GotoPlay(
        // currentRound, records
        ));
  }

  // maybe send record directly through parameter here?
  void endRound() {
    final records = <String, RoundRecord>{};
    for (final player in playerPrediction.keys) {
      final record = RoundRecord(
        roundNumber: currentRound,
        player: player,
        winsPredicted: playerPrediction[player] ?? 0,
        actualWins: playerWins[player] ?? 0,
        bonus: playerBonus[player] ?? 0,
      );
      records[player] = record;
    }

    print(_sessionState.record.recordList);
    print('adding records: $records');
    _sessionState.record
        .modifyRecord(roundNumber: currentRound - 1, record: records);
    print(_sessionState.record.recordList);
    final newRecords = <String, RoundRecord>{};
    if (currentRound >= _sessionState.record.recordList.length) {
      for (final entry in playerPrediction.entries) {
        final player = entry.key;
        final record = RoundRecord(
          roundNumber: currentRound + 1,
          player: player,
          winsPredicted: 0,
          actualWins: 0,
          bonus: 0,
        );
        newRecords[player] = record;
      }
      _sessionState.record.addRecord(newRecords);
      // final newGameRecord = GameRecord(
      //   players: _sessionState.record.players,
      //   roundNumber: currentRound + 1,
      //   records: _sessionState.record.recordList,
      // );
      print(_sessionState.record.recordList);
      // _sessionState.add(GameState(_sessionState.last.state, newGameRecord));
    }
    currentRound++;

    gameFsm.send(EndRound());
  }

  void goToRound(int roundNumber) {}

  void goForward() {
    gameFsm.send(GoForward());
  }

  void goBackward() {
    gameFsm.send(GoBackward(
        // roundNumber, records
        ));
  }

  // GameState get session =>
  //     _sessionHistory.isEmpty ? GameState([]) : _sessionHistory.last;

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
              ])
              ..on<ViewGameHistory, History>(),
          )
          ..state<InitGame>(
            builder: (g) => g
              ..onEntry((_) {})
              ..on<InitGameFinished, Playing>(
                actions: [
                  (gameSetUp) => _sessionState = GameState(
                        PreGameState,
                        GameRecord(
                          players: gameSetUp.players,
                        ),
                      ),
                ],
              )
              ..on<Exit, Home>(),
          )
          ..state<Playing>(
            builder: (g) => g
              ..onEntry((_) {
                startGame();
              })
              ..on<GameFinished, Home>()
              ..on<Exit, Home>(),
          )
          ..state<History>(
            builder: (g) => g
              ..onEntry((_) {})
              ..on<Exit, Home>(),
          ),
      );

  StateMachine _gameStateMachineSetup() => StateMachine.create(
        id: 'skull_king_game_fsm',
        (g) => g
          ..initial<PreGameState>()
          ..state<PreGameState>(
            builder: (g) => g
              ..onEntry(
                (_) {},
              )
              ..on<StartNewGame, Prediction>(actions: [(_) => currentRound = 1])
              ..on<GotoPlay, Play>(),
          )
          ..state<Prediction>(
            builder: (g) => g
              ..onEntry(
                (_) {
                  print('entered  prediction');
                },
              )
              ..on<GotoPlay, Play>()
              ..on<GoForward, Play>()
              ..on<GoBackward, Play>(
                  condition: (_) => currentRound > 1,
                  actions: [(_) => currentRound--])
              ..on<GoBackward, PreGameState>(),
          )
          ..state<Play>(
            builder: (g) => g
              ..onEntry(
                (_) {
                  print('entered  play');
                },
              )
              ..on<EndRound, Prediction>(
                condition: (e) => currentRound < 11,
              )
              ..on<EndRound, GameEnd>(
                condition: (e) => currentRound == 11,
              )
              ..on<GoForward, Prediction>(
                  condition: (e) => currentRound < 11,
                  actions: [(_) => currentRound++])
              ..on<GoForward, GameEnd>(
                condition: (e) => currentRound == 11,
              )
              ..on<GoBackward, Prediction>(),
          )
          ..state<GameEnd>(
            builder: (g) => g
              ..onEntry(
                (_) {},
              )
              ..on<EndRound, Prediction>()
              ..on<GotoPrediction, Prediction>()
              ..on<GotoPlay, Play>()
              ..on<GoForward, PreGameState>()
              ..on<GoBackward, Play>(),
          ),
      );
}

class GameState {
  Type state;
  int currentRound = 0;
  final GameRecord record;

  GameState(this.state, this.record);
}

// states
// app fsm

class Home implements AutomataState {}

class InitGame implements AutomataState {}

class Playing implements AutomataState {}

class History implements AutomataState {}

class Result implements AutomataState {}

// game fsm

class PreGameState implements AutomataState {}

class Prediction implements AutomataState {}

class Play implements AutomataState {}

class GameEnd implements AutomataState {}

// events
// app state events

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

// game state events

class GotoSetUpGameState implements AutomataEvent {}

class EndRound implements AutomataEvent {}

class GotoPlay implements AutomataEvent {
  // final int roundNumber;
  // final Map<String, RoundRecord> records;

  // const GotoPlay(this.roundNumber, this.records);
}

class GotoPrediction implements AutomataEvent {
  final int roundNumber;
  final Map<String, RoundRecord> records;

  const GotoPrediction(this.roundNumber, this.records);
}

class GoForward implements AutomataEvent {}

class GoBackward implements AutomataEvent {}
