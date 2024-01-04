import 'game_state.dart';

class SkullKingController {
  final SkullKingState gameState;

  Stream<GameState> get stateStream => gameState.stateStream;

  const SkullKingController(this.gameState);

  void startNewGame() {
    gameState.appFsm.send(StartNewGame());
  }

  void completeGameSetUp(List<String> players) {
    gameState.appFsm.send(InitGameFinished(players));
  }

  void exitState() {
    gameState.appFsm.send(Exit());
  }
}
