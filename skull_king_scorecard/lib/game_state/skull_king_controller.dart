import 'game_state.dart';

class SkullKingController {
  final SkullKingState gameState;

  Stream<Type> get appStateStream => gameState.stateStream;

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
