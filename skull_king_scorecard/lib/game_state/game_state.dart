import 'package:automata/automata.dart';
import 'package:stream_transform/stream_transform.dart';

import 'game_session_tokens.dart';

class SkullKingState {
  late final StateMachine appFsm;
  late final StateMachine gameFsm;
  late final Stream<GameState> stateStream;
  SkullKingState() {
    appFsm = _appStateMachineSetup();
    gameFsm = _gameStateMachineSetup();
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

StateMachine _gameStateMachineSetup() => StateMachine.create(
      id: 'skull_king_game_fsm',
      (g) => g
        ..initial<SetUpGameState>()
        ..state<SetUpGameState>(
          builder: (g) => g
            ..onEntry(
              (_) {},
            )
            ..on<GotoFirstPrediction, FirstPrediction>()
            ..on<GotoSecondPrediction, SecondPrediction>()
            ..on<GotoThirdPrediction, ThirdPrediction>()
            ..on<GotoFourthPrediction, FourthPrediction>()
            ..on<GotoFifthPrediction, FifthPrediction>()
            ..on<GotoSixthPrediction, SixthPrediction>()
            ..on<GotoSeventhPrediction, SeventhPrediction>()
            ..on<GotoEighthPrediction, EighthPrediction>()
            ..on<GotoNinthPrediction, NinthPrediction>()
            ..on<GotoTenthPrediction, TenthPrediction>()
            ..on<GotoFirstPlay, FirstPlay>()
            ..on<GotoSecondPlay, SecondPlay>()
            ..on<GotoThirdPlay, ThirdPlay>()
            ..on<GotoFourthPlay, FourthPlay>()
            ..on<GotoFifthPlay, FifthPlay>()
            ..on<GotoSixthPlay, SixthPlay>()
            ..on<GotoSeventhPlay, SeventhPlay>()
            ..on<GotoEighthPlay, EighthPlay>()
            ..on<GotoNinthPlay, NinthPlay>()
            ..on<GotoTenthPlay, TenthPlay>(),
        )
        ..state<FirstPrediction>(
          builder: (g) => g
            ..onEntry(
              (_) {},
            )
            ..on<GotoFirstPrediction, FirstPrediction>()
            ..on<GotoSecondPrediction, SecondPrediction>()
            ..on<GotoThirdPrediction, ThirdPrediction>()
            ..on<GotoFourthPrediction, FourthPrediction>()
            ..on<GotoFifthPrediction, FifthPrediction>()
            ..on<GotoSixthPrediction, SixthPrediction>()
            ..on<GotoSeventhPrediction, SeventhPrediction>()
            ..on<GotoEighthPrediction, EighthPrediction>()
            ..on<GotoNinthPrediction, NinthPrediction>()
            ..on<GotoTenthPrediction, TenthPrediction>()
            ..on<GotoFirstPlay, FirstPlay>()
            ..on<GotoSecondPlay, SecondPlay>()
            ..on<GotoThirdPlay, ThirdPlay>()
            ..on<GotoFourthPlay, FourthPlay>()
            ..on<GotoFifthPlay, FifthPlay>()
            ..on<GotoSixthPlay, SixthPlay>()
            ..on<GotoSeventhPlay, SeventhPlay>()
            ..on<GotoEighthPlay, EighthPlay>()
            ..on<GotoNinthPlay, NinthPlay>()
            ..on<GotoTenthPlay, TenthPlay>()
            ..on<GoForward, FirstPlay>()
            ..on<GoBackward, SetUpGameState>(),
        )
        ..state<SecondPrediction>(
          builder: (g) => g
            ..onEntry(
              (_) {},
            )
            ..on<GotoFirstPrediction, FirstPrediction>()
            ..on<GotoSecondPrediction, SecondPrediction>()
            ..on<GotoThirdPrediction, ThirdPrediction>()
            ..on<GotoFourthPrediction, FourthPrediction>()
            ..on<GotoFifthPrediction, FifthPrediction>()
            ..on<GotoSixthPrediction, SixthPrediction>()
            ..on<GotoSeventhPrediction, SeventhPrediction>()
            ..on<GotoEighthPrediction, EighthPrediction>()
            ..on<GotoNinthPrediction, NinthPrediction>()
            ..on<GotoTenthPrediction, TenthPrediction>()
            ..on<GotoFirstPlay, FirstPlay>()
            ..on<GotoSecondPlay, SecondPlay>()
            ..on<GotoThirdPlay, ThirdPlay>()
            ..on<GotoFourthPlay, FourthPlay>()
            ..on<GotoFifthPlay, FifthPlay>()
            ..on<GotoSixthPlay, SixthPlay>()
            ..on<GotoSeventhPlay, SeventhPlay>()
            ..on<GotoEighthPlay, EighthPlay>()
            ..on<GotoNinthPlay, NinthPlay>()
            ..on<GotoTenthPlay, TenthPlay>()
            ..on<GoForward, SecondPlay>()
            ..on<GoBackward, FirstPlay>(),
        )
        ..state<ThirdPrediction>(
          builder: (g) => g
            ..onEntry(
              (_) {},
            )
            ..on<GotoFirstPrediction, FirstPrediction>()
            ..on<GotoSecondPrediction, SecondPrediction>()
            ..on<GotoThirdPrediction, ThirdPrediction>()
            ..on<GotoFourthPrediction, FourthPrediction>()
            ..on<GotoFifthPrediction, FifthPrediction>()
            ..on<GotoSixthPrediction, SixthPrediction>()
            ..on<GotoSeventhPrediction, SeventhPrediction>()
            ..on<GotoEighthPrediction, EighthPrediction>()
            ..on<GotoNinthPrediction, NinthPrediction>()
            ..on<GotoTenthPrediction, TenthPrediction>()
            ..on<GotoFirstPlay, FirstPlay>()
            ..on<GotoSecondPlay, SecondPlay>()
            ..on<GotoThirdPlay, ThirdPlay>()
            ..on<GotoFourthPlay, FourthPlay>()
            ..on<GotoFifthPlay, FifthPlay>()
            ..on<GotoSixthPlay, SixthPlay>()
            ..on<GotoSeventhPlay, SeventhPlay>()
            ..on<GotoEighthPlay, EighthPlay>()
            ..on<GotoNinthPlay, NinthPlay>()
            ..on<GotoTenthPlay, TenthPlay>()
            ..on<GoForward, ThirdPlay>()
            ..on<GoBackward, SecondPlay>(),
        )
        ..state<FourthPrediction>(
          builder: (g) => g
            ..onEntry(
              (_) {},
            )
            ..on<GotoFirstPrediction, FirstPrediction>()
            ..on<GotoSecondPrediction, SecondPrediction>()
            ..on<GotoThirdPrediction, ThirdPrediction>()
            ..on<GotoFourthPrediction, FourthPrediction>()
            ..on<GotoFifthPrediction, FifthPrediction>()
            ..on<GotoSixthPrediction, SixthPrediction>()
            ..on<GotoSeventhPrediction, SeventhPrediction>()
            ..on<GotoEighthPrediction, EighthPrediction>()
            ..on<GotoNinthPrediction, NinthPrediction>()
            ..on<GotoTenthPrediction, TenthPrediction>()
            ..on<GotoFirstPlay, FirstPlay>()
            ..on<GotoSecondPlay, SecondPlay>()
            ..on<GotoThirdPlay, ThirdPlay>()
            ..on<GotoFourthPlay, FourthPlay>()
            ..on<GotoFifthPlay, FifthPlay>()
            ..on<GotoSixthPlay, SixthPlay>()
            ..on<GotoSeventhPlay, SeventhPlay>()
            ..on<GotoEighthPlay, EighthPlay>()
            ..on<GotoNinthPlay, NinthPlay>()
            ..on<GotoTenthPlay, TenthPlay>()
            ..on<GoForward, FourthPlay>()
            ..on<GoBackward, ThirdPlay>(),
        )
        ..state<FifthPrediction>(
          builder: (g) => g
            ..onEntry(
              (_) {},
            )
            ..on<GotoFirstPrediction, FirstPrediction>()
            ..on<GotoSecondPrediction, SecondPrediction>()
            ..on<GotoThirdPrediction, ThirdPrediction>()
            ..on<GotoFourthPrediction, FourthPrediction>()
            ..on<GotoFifthPrediction, FifthPrediction>()
            ..on<GotoSixthPrediction, SixthPrediction>()
            ..on<GotoSeventhPrediction, SeventhPrediction>()
            ..on<GotoEighthPrediction, EighthPrediction>()
            ..on<GotoNinthPrediction, NinthPrediction>()
            ..on<GotoTenthPrediction, TenthPrediction>()
            ..on<GotoFirstPlay, FirstPlay>()
            ..on<GotoSecondPlay, SecondPlay>()
            ..on<GotoThirdPlay, ThirdPlay>()
            ..on<GotoFourthPlay, FourthPlay>()
            ..on<GotoFifthPlay, FifthPlay>()
            ..on<GotoSixthPlay, SixthPlay>()
            ..on<GotoSeventhPlay, SeventhPlay>()
            ..on<GotoEighthPlay, EighthPlay>()
            ..on<GotoNinthPlay, NinthPlay>()
            ..on<GotoTenthPlay, TenthPlay>()
            ..on<GoForward, FifthPlay>()
            ..on<GoBackward, FourthPlay>(),
        )
        ..state<SixthPrediction>(
          builder: (g) => g
            ..onEntry(
              (_) {},
            )
            ..on<GotoFirstPrediction, FirstPrediction>()
            ..on<GotoSecondPrediction, SecondPrediction>()
            ..on<GotoThirdPrediction, ThirdPrediction>()
            ..on<GotoFourthPrediction, FourthPrediction>()
            ..on<GotoFifthPrediction, FifthPrediction>()
            ..on<GotoSixthPrediction, SixthPrediction>()
            ..on<GotoSeventhPrediction, SeventhPrediction>()
            ..on<GotoEighthPrediction, EighthPrediction>()
            ..on<GotoNinthPrediction, NinthPrediction>()
            ..on<GotoTenthPrediction, TenthPrediction>()
            ..on<GotoFirstPlay, FirstPlay>()
            ..on<GotoSecondPlay, SecondPlay>()
            ..on<GotoThirdPlay, ThirdPlay>()
            ..on<GotoFourthPlay, FourthPlay>()
            ..on<GotoFifthPlay, FifthPlay>()
            ..on<GotoSixthPlay, SixthPlay>()
            ..on<GotoSeventhPlay, SeventhPlay>()
            ..on<GotoEighthPlay, EighthPlay>()
            ..on<GotoNinthPlay, NinthPlay>()
            ..on<GotoTenthPlay, TenthPlay>()
            ..on<GoForward, SixthPlay>()
            ..on<GoBackward, FifthPlay>(),
        )
        ..state<SeventhPrediction>(
          builder: (g) => g
            ..onEntry(
              (_) {},
            )
            ..on<GotoFirstPrediction, FirstPrediction>()
            ..on<GotoSecondPrediction, SecondPrediction>()
            ..on<GotoThirdPrediction, ThirdPrediction>()
            ..on<GotoFourthPrediction, FourthPrediction>()
            ..on<GotoFifthPrediction, FifthPrediction>()
            ..on<GotoSixthPrediction, SixthPrediction>()
            ..on<GotoSeventhPrediction, SeventhPrediction>()
            ..on<GotoEighthPrediction, EighthPrediction>()
            ..on<GotoNinthPrediction, NinthPrediction>()
            ..on<GotoTenthPrediction, TenthPrediction>()
            ..on<GotoFirstPlay, FirstPlay>()
            ..on<GotoSecondPlay, SecondPlay>()
            ..on<GotoThirdPlay, ThirdPlay>()
            ..on<GotoFourthPlay, FourthPlay>()
            ..on<GotoFifthPlay, FifthPlay>()
            ..on<GotoSixthPlay, SixthPlay>()
            ..on<GotoSeventhPlay, SeventhPlay>()
            ..on<GotoEighthPlay, EighthPlay>()
            ..on<GotoNinthPlay, NinthPlay>()
            ..on<GotoTenthPlay, TenthPlay>()
            ..on<GoForward, SeventhPlay>()
            ..on<GoBackward, SixthPlay>(),
        )
        ..state<EighthPrediction>(
          builder: (g) => g
            ..onEntry(
              (_) {},
            )
            ..on<GotoFirstPrediction, FirstPrediction>()
            ..on<GotoSecondPrediction, SecondPrediction>()
            ..on<GotoThirdPrediction, ThirdPrediction>()
            ..on<GotoFourthPrediction, FourthPrediction>()
            ..on<GotoFifthPrediction, FifthPrediction>()
            ..on<GotoSixthPrediction, SixthPrediction>()
            ..on<GotoSeventhPrediction, SeventhPrediction>()
            ..on<GotoEighthPrediction, EighthPrediction>()
            ..on<GotoNinthPrediction, NinthPrediction>()
            ..on<GotoTenthPrediction, TenthPrediction>()
            ..on<GotoFirstPlay, FirstPlay>()
            ..on<GotoSecondPlay, SecondPlay>()
            ..on<GotoThirdPlay, ThirdPlay>()
            ..on<GotoFourthPlay, FourthPlay>()
            ..on<GotoFifthPlay, FifthPlay>()
            ..on<GotoSixthPlay, SixthPlay>()
            ..on<GotoSeventhPlay, SeventhPlay>()
            ..on<GotoEighthPlay, EighthPlay>()
            ..on<GotoNinthPlay, NinthPlay>()
            ..on<GotoTenthPlay, TenthPlay>()
            ..on<GoForward, EighthPlay>()
            ..on<GoBackward, SeventhPlay>(),
        )
        ..state<NinthPrediction>(
          builder: (g) => g
            ..onEntry(
              (_) {},
            )
            ..on<GotoFirstPrediction, FirstPrediction>()
            ..on<GotoSecondPrediction, SecondPrediction>()
            ..on<GotoThirdPrediction, ThirdPrediction>()
            ..on<GotoFourthPrediction, FourthPrediction>()
            ..on<GotoFifthPrediction, FifthPrediction>()
            ..on<GotoSixthPrediction, SixthPrediction>()
            ..on<GotoSeventhPrediction, SeventhPrediction>()
            ..on<GotoEighthPrediction, EighthPrediction>()
            ..on<GotoNinthPrediction, NinthPrediction>()
            ..on<GotoTenthPrediction, TenthPrediction>()
            ..on<GotoFirstPlay, FirstPlay>()
            ..on<GotoSecondPlay, SecondPlay>()
            ..on<GotoThirdPlay, ThirdPlay>()
            ..on<GotoFourthPlay, FourthPlay>()
            ..on<GotoFifthPlay, FifthPlay>()
            ..on<GotoSixthPlay, SixthPlay>()
            ..on<GotoSeventhPlay, SeventhPlay>()
            ..on<GotoEighthPlay, EighthPlay>()
            ..on<GotoNinthPlay, NinthPlay>()
            ..on<GotoTenthPlay, TenthPlay>()
            ..on<GoForward, NinthPlay>()
            ..on<GoBackward, EighthPlay>(),
        )
        ..state<TenthPrediction>(
          builder: (g) => g
            ..onEntry(
              (_) {},
            )
            ..on<GotoFirstPrediction, FirstPrediction>()
            ..on<GotoSecondPrediction, SecondPrediction>()
            ..on<GotoThirdPrediction, ThirdPrediction>()
            ..on<GotoFourthPrediction, FourthPrediction>()
            ..on<GotoFifthPrediction, FifthPrediction>()
            ..on<GotoSixthPrediction, SixthPrediction>()
            ..on<GotoSeventhPrediction, SeventhPrediction>()
            ..on<GotoEighthPrediction, EighthPrediction>()
            ..on<GotoNinthPrediction, NinthPrediction>()
            ..on<GotoTenthPrediction, TenthPrediction>()
            ..on<GotoFirstPlay, FirstPlay>()
            ..on<GotoSecondPlay, SecondPlay>()
            ..on<GotoThirdPlay, ThirdPlay>()
            ..on<GotoFourthPlay, FourthPlay>()
            ..on<GotoFifthPlay, FifthPlay>()
            ..on<GotoSixthPlay, SixthPlay>()
            ..on<GotoSeventhPlay, SeventhPlay>()
            ..on<GotoEighthPlay, EighthPlay>()
            ..on<GotoNinthPlay, NinthPlay>()
            ..on<GotoTenthPlay, TenthPlay>()
            ..on<GoForward, TenthPlay>()
            ..on<GoBackward, NinthPlay>(),
        )
        ..state<FirstPlay>(
          builder: (g) => g
            ..onEntry(
              (_) {},
            )
            ..on<GotoFirstPrediction, FirstPrediction>()
            ..on<GotoSecondPrediction, SecondPrediction>()
            ..on<GotoThirdPrediction, ThirdPrediction>()
            ..on<GotoFourthPrediction, FourthPrediction>()
            ..on<GotoFifthPrediction, FifthPrediction>()
            ..on<GotoSixthPrediction, SixthPrediction>()
            ..on<GotoSeventhPrediction, SeventhPrediction>()
            ..on<GotoEighthPrediction, EighthPrediction>()
            ..on<GotoNinthPrediction, NinthPrediction>()
            ..on<GotoTenthPrediction, TenthPrediction>()
            ..on<GotoFirstPlay, FirstPlay>()
            ..on<GotoSecondPlay, SecondPlay>()
            ..on<GotoThirdPlay, ThirdPlay>()
            ..on<GotoFourthPlay, FourthPlay>()
            ..on<GotoFifthPlay, FifthPlay>()
            ..on<GotoSixthPlay, SixthPlay>()
            ..on<GotoSeventhPlay, SeventhPlay>()
            ..on<GotoEighthPlay, EighthPlay>()
            ..on<GotoNinthPlay, NinthPlay>()
            ..on<GotoTenthPlay, TenthPlay>()
            ..on<GoForward, SecondPrediction>()
            ..on<GoBackward, FirstPrediction>(),
        )
        ..state<SecondPlay>(
          builder: (g) => g
            ..onEntry(
              (_) {},
            )
            ..on<GotoFirstPrediction, FirstPrediction>()
            ..on<GotoSecondPrediction, SecondPrediction>()
            ..on<GotoThirdPrediction, ThirdPrediction>()
            ..on<GotoFourthPrediction, FourthPrediction>()
            ..on<GotoFifthPrediction, FifthPrediction>()
            ..on<GotoSixthPrediction, SixthPrediction>()
            ..on<GotoSeventhPrediction, SeventhPrediction>()
            ..on<GotoEighthPrediction, EighthPrediction>()
            ..on<GotoNinthPrediction, NinthPrediction>()
            ..on<GotoTenthPrediction, TenthPrediction>()
            ..on<GotoFirstPlay, FirstPlay>()
            ..on<GotoSecondPlay, SecondPlay>()
            ..on<GotoThirdPlay, ThirdPlay>()
            ..on<GotoFourthPlay, FourthPlay>()
            ..on<GotoFifthPlay, FifthPlay>()
            ..on<GotoSixthPlay, SixthPlay>()
            ..on<GotoSeventhPlay, SeventhPlay>()
            ..on<GotoEighthPlay, EighthPlay>()
            ..on<GotoNinthPlay, NinthPlay>()
            ..on<GotoTenthPlay, TenthPlay>()
            ..on<GoForward, ThirdPrediction>()
            ..on<GoBackward, SecondPrediction>(),
        )
        ..state<ThirdPlay>(
          builder: (g) => g
            ..onEntry(
              (_) {},
            )
            ..on<GotoFirstPrediction, FirstPrediction>()
            ..on<GotoSecondPrediction, SecondPrediction>()
            ..on<GotoThirdPrediction, ThirdPrediction>()
            ..on<GotoFourthPrediction, FourthPrediction>()
            ..on<GotoFifthPrediction, FifthPrediction>()
            ..on<GotoSixthPrediction, SixthPrediction>()
            ..on<GotoSeventhPrediction, SeventhPrediction>()
            ..on<GotoEighthPrediction, EighthPrediction>()
            ..on<GotoNinthPrediction, NinthPrediction>()
            ..on<GotoTenthPrediction, TenthPrediction>()
            ..on<GotoFirstPlay, FirstPlay>()
            ..on<GotoSecondPlay, SecondPlay>()
            ..on<GotoThirdPlay, ThirdPlay>()
            ..on<GotoFourthPlay, FourthPlay>()
            ..on<GotoFifthPlay, FifthPlay>()
            ..on<GotoSixthPlay, SixthPlay>()
            ..on<GotoSeventhPlay, SeventhPlay>()
            ..on<GotoEighthPlay, EighthPlay>()
            ..on<GotoNinthPlay, NinthPlay>()
            ..on<GotoTenthPlay, TenthPlay>()
            ..on<GoForward, FourthPrediction>()
            ..on<GoBackward, ThirdPrediction>(),
        )
        ..state<FourthPlay>(
          builder: (g) => g
            ..onEntry(
              (_) {},
            )
            ..on<GotoFirstPrediction, FirstPrediction>()
            ..on<GotoSecondPrediction, SecondPrediction>()
            ..on<GotoThirdPrediction, ThirdPrediction>()
            ..on<GotoFourthPrediction, FourthPrediction>()
            ..on<GotoFifthPrediction, FifthPrediction>()
            ..on<GotoSixthPrediction, SixthPrediction>()
            ..on<GotoSeventhPrediction, SeventhPrediction>()
            ..on<GotoEighthPrediction, EighthPrediction>()
            ..on<GotoNinthPrediction, NinthPrediction>()
            ..on<GotoTenthPrediction, TenthPrediction>()
            ..on<GotoFirstPlay, FirstPlay>()
            ..on<GotoSecondPlay, SecondPlay>()
            ..on<GotoThirdPlay, ThirdPlay>()
            ..on<GotoFourthPlay, FourthPlay>()
            ..on<GotoFifthPlay, FifthPlay>()
            ..on<GotoSixthPlay, SixthPlay>()
            ..on<GotoSeventhPlay, SeventhPlay>()
            ..on<GotoEighthPlay, EighthPlay>()
            ..on<GotoNinthPlay, NinthPlay>()
            ..on<GotoTenthPlay, TenthPlay>()
            ..on<GoForward, FifthPrediction>()
            ..on<GoBackward, FourthPrediction>(),
        )
        ..state<FifthPlay>(
          builder: (g) => g
            ..onEntry(
              (_) {},
            )
            ..on<GotoFirstPrediction, FirstPrediction>()
            ..on<GotoSecondPrediction, SecondPrediction>()
            ..on<GotoThirdPrediction, ThirdPrediction>()
            ..on<GotoFourthPrediction, FourthPrediction>()
            ..on<GotoFifthPrediction, FifthPrediction>()
            ..on<GotoSixthPrediction, SixthPrediction>()
            ..on<GotoSeventhPrediction, SeventhPrediction>()
            ..on<GotoEighthPrediction, EighthPrediction>()
            ..on<GotoNinthPrediction, NinthPrediction>()
            ..on<GotoTenthPrediction, TenthPrediction>()
            ..on<GotoFirstPlay, FirstPlay>()
            ..on<GotoSecondPlay, SecondPlay>()
            ..on<GotoThirdPlay, ThirdPlay>()
            ..on<GotoFourthPlay, FourthPlay>()
            ..on<GotoFifthPlay, FifthPlay>()
            ..on<GotoSixthPlay, SixthPlay>()
            ..on<GotoSeventhPlay, SeventhPlay>()
            ..on<GotoEighthPlay, EighthPlay>()
            ..on<GotoNinthPlay, NinthPlay>()
            ..on<GotoTenthPlay, TenthPlay>()
            ..on<GoForward, SixthPrediction>()
            ..on<GoBackward, FifthPrediction>(),
        )
        ..state<SixthPlay>(
          builder: (g) => g
            ..onEntry(
              (_) {},
            )
            ..on<GotoFirstPrediction, FirstPrediction>()
            ..on<GotoSecondPrediction, SecondPrediction>()
            ..on<GotoThirdPrediction, ThirdPrediction>()
            ..on<GotoFourthPrediction, FourthPrediction>()
            ..on<GotoFifthPrediction, FifthPrediction>()
            ..on<GotoSixthPrediction, SixthPrediction>()
            ..on<GotoSeventhPrediction, SeventhPrediction>()
            ..on<GotoEighthPrediction, EighthPrediction>()
            ..on<GotoNinthPrediction, NinthPrediction>()
            ..on<GotoTenthPrediction, TenthPrediction>()
            ..on<GotoFirstPlay, FirstPlay>()
            ..on<GotoSecondPlay, SecondPlay>()
            ..on<GotoThirdPlay, ThirdPlay>()
            ..on<GotoFourthPlay, FourthPlay>()
            ..on<GotoFifthPlay, FifthPlay>()
            ..on<GotoSixthPlay, SixthPlay>()
            ..on<GotoSeventhPlay, SeventhPlay>()
            ..on<GotoEighthPlay, EighthPlay>()
            ..on<GotoNinthPlay, NinthPlay>()
            ..on<GotoTenthPlay, TenthPlay>()
            ..on<GoForward, SeventhPrediction>()
            ..on<GoBackward, SixthPrediction>(),
        )
        ..state<SeventhPlay>(
          builder: (g) => g
            ..onEntry(
              (_) {},
            )
            ..on<GotoFirstPrediction, FirstPrediction>()
            ..on<GotoSecondPrediction, SecondPrediction>()
            ..on<GotoThirdPrediction, ThirdPrediction>()
            ..on<GotoFourthPrediction, FourthPrediction>()
            ..on<GotoFifthPrediction, FifthPrediction>()
            ..on<GotoSixthPrediction, SixthPrediction>()
            ..on<GotoSeventhPrediction, SeventhPrediction>()
            ..on<GotoEighthPrediction, EighthPrediction>()
            ..on<GotoNinthPrediction, NinthPrediction>()
            ..on<GotoTenthPrediction, TenthPrediction>()
            ..on<GotoFirstPlay, FirstPlay>()
            ..on<GotoSecondPlay, SecondPlay>()
            ..on<GotoThirdPlay, ThirdPlay>()
            ..on<GotoFourthPlay, FourthPlay>()
            ..on<GotoFifthPlay, FifthPlay>()
            ..on<GotoSixthPlay, SixthPlay>()
            ..on<GotoSeventhPlay, SeventhPlay>()
            ..on<GotoEighthPlay, EighthPlay>()
            ..on<GotoNinthPlay, NinthPlay>()
            ..on<GotoTenthPlay, TenthPlay>()
            ..on<GoForward, EighthPrediction>()
            ..on<GoBackward, SeventhPrediction>(),
        )
        ..state<EighthPlay>(
          builder: (g) => g
            ..onEntry(
              (_) {},
            )
            ..on<GotoFirstPrediction, FirstPrediction>()
            ..on<GotoSecondPrediction, SecondPrediction>()
            ..on<GotoThirdPrediction, ThirdPrediction>()
            ..on<GotoFourthPrediction, FourthPrediction>()
            ..on<GotoFifthPrediction, FifthPrediction>()
            ..on<GotoSixthPrediction, SixthPrediction>()
            ..on<GotoSeventhPrediction, SeventhPrediction>()
            ..on<GotoEighthPrediction, EighthPrediction>()
            ..on<GotoNinthPrediction, NinthPrediction>()
            ..on<GotoTenthPrediction, TenthPrediction>()
            ..on<GotoFirstPlay, FirstPlay>()
            ..on<GotoSecondPlay, SecondPlay>()
            ..on<GotoThirdPlay, ThirdPlay>()
            ..on<GotoFourthPlay, FourthPlay>()
            ..on<GotoFifthPlay, FifthPlay>()
            ..on<GotoSixthPlay, SixthPlay>()
            ..on<GotoSeventhPlay, SeventhPlay>()
            ..on<GotoEighthPlay, EighthPlay>()
            ..on<GotoNinthPlay, NinthPlay>()
            ..on<GotoTenthPlay, TenthPlay>()
            ..on<GoForward, NinthPrediction>()
            ..on<GoBackward, EighthPrediction>(),
        )
        ..state<NinthPlay>(
          builder: (g) => g
            ..onEntry(
              (_) {},
            )
            ..on<GotoFirstPrediction, FirstPrediction>()
            ..on<GotoSecondPrediction, SecondPrediction>()
            ..on<GotoThirdPrediction, ThirdPrediction>()
            ..on<GotoFourthPrediction, FourthPrediction>()
            ..on<GotoFifthPrediction, FifthPrediction>()
            ..on<GotoSixthPrediction, SixthPrediction>()
            ..on<GotoSeventhPrediction, SeventhPrediction>()
            ..on<GotoEighthPrediction, EighthPrediction>()
            ..on<GotoNinthPrediction, NinthPrediction>()
            ..on<GotoTenthPrediction, TenthPrediction>()
            ..on<GotoFirstPlay, FirstPlay>()
            ..on<GotoSecondPlay, SecondPlay>()
            ..on<GotoThirdPlay, ThirdPlay>()
            ..on<GotoFourthPlay, FourthPlay>()
            ..on<GotoFifthPlay, FifthPlay>()
            ..on<GotoSixthPlay, SixthPlay>()
            ..on<GotoSeventhPlay, SeventhPlay>()
            ..on<GotoEighthPlay, EighthPlay>()
            ..on<GotoNinthPlay, NinthPlay>()
            ..on<GotoTenthPlay, TenthPlay>()
            ..on<GoForward, TenthPrediction>()
            ..on<GoBackward, NinthPrediction>(),
        )
        ..state<TenthPlay>(
          builder: (g) => g
            ..onEntry(
              (_) {},
            )
            ..on<GotoFirstPrediction, FirstPrediction>()
            ..on<GotoSecondPrediction, SecondPrediction>()
            ..on<GotoThirdPrediction, ThirdPrediction>()
            ..on<GotoFourthPrediction, FourthPrediction>()
            ..on<GotoFifthPrediction, FifthPrediction>()
            ..on<GotoSixthPrediction, SixthPrediction>()
            ..on<GotoSeventhPrediction, SeventhPrediction>()
            ..on<GotoEighthPrediction, EighthPrediction>()
            ..on<GotoNinthPrediction, NinthPrediction>()
            ..on<GotoTenthPrediction, TenthPrediction>()
            ..on<GotoFirstPlay, FirstPlay>()
            ..on<GotoSecondPlay, SecondPlay>()
            ..on<GotoThirdPlay, ThirdPlay>()
            ..on<GotoFourthPlay, FourthPlay>()
            ..on<GotoFifthPlay, FifthPlay>()
            ..on<GotoSixthPlay, SixthPlay>()
            ..on<GotoSeventhPlay, SeventhPlay>()
            ..on<GotoEighthPlay, EighthPlay>()
            ..on<GotoNinthPlay, NinthPlay>()
            ..on<GotoTenthPlay, TenthPlay>()
            ..on<GoForward, GameEnd>()
            ..on<GoBackward, TenthPrediction>(),
        )
        ..state<GameEnd>(
          builder: (g) => g
            ..onEntry(
              (_) {},
            )
            ..on<GotoFirstPrediction, FirstPrediction>()
            ..on<GotoSecondPrediction, SecondPrediction>()
            ..on<GotoThirdPrediction, ThirdPrediction>()
            ..on<GotoFourthPrediction, FourthPrediction>()
            ..on<GotoFifthPrediction, FifthPrediction>()
            ..on<GotoSixthPrediction, SixthPrediction>()
            ..on<GotoSeventhPrediction, SeventhPrediction>()
            ..on<GotoEighthPrediction, EighthPrediction>()
            ..on<GotoNinthPrediction, NinthPrediction>()
            ..on<GotoTenthPrediction, TenthPrediction>()
            ..on<GotoFirstPlay, FirstPlay>()
            ..on<GotoSecondPlay, SecondPlay>()
            ..on<GotoThirdPlay, ThirdPlay>()
            ..on<GotoFourthPlay, FourthPlay>()
            ..on<GotoFifthPlay, FifthPlay>()
            ..on<GotoSixthPlay, SixthPlay>()
            ..on<GotoSeventhPlay, SeventhPlay>()
            ..on<GotoEighthPlay, EighthPlay>()
            ..on<GotoNinthPlay, NinthPlay>()
            ..on<GotoTenthPlay, TenthPlay>()
            ..on<GoForward, SetUpGameState>()
            ..on<GoBackward, TenthPlay>(),
        ),
    );

class GameState {
  final Type state;
  final GameSessionToken session;

  const GameState(this.state, this.session);
}

// states
// app fsm

class Home implements AutomataState {}

class InitGame implements AutomataState {}

class Playing implements AutomataState {}

class History implements AutomataState {}

class Prediction implements AutomataState {}

class Result implements AutomataState {}

// game fsm

class SetUpGameState implements AutomataState {}

class FirstPrediction implements AutomataState {}

class SecondPrediction implements AutomataState {}

class ThirdPrediction implements AutomataState {}

class FourthPrediction implements AutomataState {}

class FifthPrediction implements AutomataState {}

class SixthPrediction implements AutomataState {}

class SeventhPrediction implements AutomataState {}

class EighthPrediction implements AutomataState {}

class NinthPrediction implements AutomataState {}

class TenthPrediction implements AutomataState {}

class FirstPlay implements AutomataState {}

class SecondPlay implements AutomataState {}

class ThirdPlay implements AutomataState {}

class FourthPlay implements AutomataState {}

class FifthPlay implements AutomataState {}

class SixthPlay implements AutomataState {}

class SeventhPlay implements AutomataState {}

class EighthPlay implements AutomataState {}

class NinthPlay implements AutomataState {}

class TenthPlay implements AutomataState {}

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

class GotoFirstPrediction implements AutomataEvent {}

class GotoSecondPrediction implements AutomataEvent {}

class GotoThirdPrediction implements AutomataEvent {}

class GotoFourthPrediction implements AutomataEvent {}

class GotoFifthPrediction implements AutomataEvent {}

class GotoSixthPrediction implements AutomataEvent {}

class GotoSeventhPrediction implements AutomataEvent {}

class GotoEighthPrediction implements AutomataEvent {}

class GotoNinthPrediction implements AutomataEvent {}

class GotoTenthPrediction implements AutomataEvent {}

class GotoFirstPlay implements AutomataEvent {}

class GotoSecondPlay implements AutomataEvent {}

class GotoThirdPlay implements AutomataEvent {}

class GotoFourthPlay implements AutomataEvent {}

class GotoFifthPlay implements AutomataEvent {}

class GotoSixthPlay implements AutomataEvent {}

class GotoSeventhPlay implements AutomataEvent {}

class GotoEighthPlay implements AutomataEvent {}

class GotoNinthPlay implements AutomataEvent {}

class GotoTenthPlay implements AutomataEvent {}

class GoForward implements AutomataEvent {}

class GoBackward implements AutomataEvent {}
