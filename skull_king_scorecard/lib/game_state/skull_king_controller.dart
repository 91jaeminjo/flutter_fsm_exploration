import 'game_records.dart';
import 'game_state.dart';

class SkullKingController {
  final SkullKingState gameState;

  Stream<Type> get appStateStream => gameState.stateStream;
  Stream<GameState> get gameStateStream => gameState.gameStream;

  SkullKingController(this.gameState);

  void startNewGame() {
    gameState.appFsm.send(StartNewGame());
  }

  void completeGameSetUp(List<String> players) {
    gameState.appFsm.send(InitGameFinished(players));
  }

  void exitState() {
    gameState.appFsm.send(Exit());
  }

  void recordPlayerPredictions(
          {required String player, required int prediction}) =>
      gameState.recordPlayerPredictions(player: player, prediction: prediction);

  void recordPlayerWins({required String player, required int wins}) =>
      gameState.recordPlayerWins(player: player, wins: wins);

  void startRound() => gameState.startRound();

  void endRound() => gameState.endRound();

  void forward() => gameState.goForward();

  void back() => gameState.goBackward();

  void goToRound(int roundNumber) => gameState.goToRound(roundNumber);
}
