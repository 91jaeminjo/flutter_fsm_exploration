import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skull_king_scorecard/game_state/game_records.dart';
import 'package:skull_king_scorecard/ui/browsing/controllers.dart';
import 'package:skull_king_scorecard/ui/ui_extensions/interleaved_widgets.dart';

import '/game_state.dart';
import '/ui/controls.dart';

import 'player_score_card.dart';

class GamePage extends ConsumerWidget {
  const GamePage({super.key});

  // int roundNumber = 1;
  // bool roundStarted = false;
  // late int roundNumberIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(skullKingController);

    final textControllers = <String, TextEditingController>{};
    // final gamePredictionRecord = <String, int>{};
    // final gameWinRecord = <String, int>{};
    // final gameRoundBonusRecord = <String, int>{};
    return SingleChildScrollView(
      child: Column(
        children: [
          StreamBuilder<GameState>(
            stream: controller.gameStateStream,
            builder: (context, snapshot) {
              final gameState = snapshot.data;
              if (gameState == null) {
                return Container();
              }
              final isAtLatestState =
                  (gameState.record.recordList.length + 1) ==
                      gameState.currentRound;

              print(
                  'inside streambuilder: gameState record recordList ${gameState.record.recordList}');
              print('round number: ${gameState.currentRound - 1}');
              final players = gameState.record.players;
              for (String player in players) {
                textControllers[player] = TextEditingController();
              }
              switch (gameState.state) {
                case Prediction:
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          for (int i = 1; i <= 10; i++)
                            SizedBox(
                              height: 30,
                              width: 30,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: const CircleBorder(),
                                  backgroundColor:
                                      i > gameState.record.recordList.length
                                          ? Colors.grey
                                          : Theme.of(context)
                                              .colorScheme
                                              .inversePrimary,
                                ),
                                onPressed: () {
                                  // setState(() {
                                  // winsPredicted = i;
                                  controller.goToRound(i);
                                  // });
                                },
                                child: Text('$i'),
                              ),
                            ),
                        ].interleave(
                          const SizedBox(
                            width: 4,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Round ${gameState.currentRound}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .fontSize,
                            height: 4,
                          ),
                        ),
                      ),
                      for (String player in players)
                        PlayerScoreCard(
                          playerName: player,
                          roundNumber: gameState.currentRound,
                          roundStarted: false,
                          bonusTextController: textControllers[player]!,
                          playerRoundRecord:
                              gameState.record.recordList.length <
                                      gameState.currentRound
                                  ? {}
                                  : gameState.record
                                      .recordList[gameState.currentRound - 1],
                          key: ValueKey('${gameState.currentRound - 1}$player'),
                        ),
                      Row(
                        children: [
                          OutlinedButton(
                            onPressed: gameState.currentRound > 1
                                ? () {
                                    controller.back();
                                  }
                                : null,
                            child: const Text('Back'),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              controller.startRound();
                            },
                            child: const Text('Start Round'),
                          ),
                        ],
                      ),
                    ],
                  );
                case Play:
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          for (int i = 1; i <= 10; i++)
                            SizedBox(
                              height: 30,
                              width: 30,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: const CircleBorder(),
                                  backgroundColor:
                                      i > gameState.record.recordList.length
                                          ? Colors.grey
                                          : Theme.of(context)
                                              .colorScheme
                                              .inversePrimary,
                                ),
                                onPressed: () {
                                  // setState(() {
                                  // winsPredicted = i;
                                  controller.goToRound(i);
                                  // });
                                },
                                child: Text('$i'),
                              ),
                            ),
                        ].interleave(
                          const SizedBox(
                            width: 4,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Round ${gameState.currentRound}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .fontSize,
                            height: 4,
                          ),
                        ),
                      ),
                      for (String player in players)
                        PlayerScoreCard(
                          playerName: player,
                          roundNumber: gameState.currentRound,
                          roundStarted: true,
                          bonusTextController: textControllers[player]!,
                          playerRoundRecord:
                              gameState.record.recordList.length <
                                      gameState.currentRound
                                  ? {}
                                  : gameState.record
                                      .recordList[gameState.currentRound - 1],
                          key: ValueKey(player),
                        ),
                      Row(
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              controller.back();
                            },
                            child: const Text('Back'),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              controller.endRound();
                            },
                            child: const Text('End Round'),
                          ),
                        ],
                      ),
                    ],
                  );
                case GameEnd:
                default:
                  return Container();
              }
              // return Container();
            },
          ),
          const ExitButton(),
        ],
      ),
    );
  }
}

class PlayerSummary extends StatelessWidget {
  final List<Map<String, RoundRecord>> recordList;
  final int roundNumber;

  const PlayerSummary(this.recordList, this.roundNumber, {super.key});

  @override
  Widget build(BuildContext context) {
    final playerTotals = <String, int>{};
    for (int i = 0; i < roundNumber; i++) {
      for (final playerEntry in recordList[i].entries) {
        playerTotals[playerEntry.key] =
            (playerTotals[playerEntry.key] ?? 0) + playerEntry.value.roundTotal;
      }
    }

    return Column(
      children: [
        for (final playerEntry in recordList[roundNumber].entries) ...[
          Text(
            '${playerEntry.key} total: ${playerTotals[playerEntry.key]}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
        const SizedBox(
          height: 12,
        ),
        for (int i = 0; i < roundNumber; i++) ...[
          for (final playerEntry in recordList[i].entries) ...[
            Text('${playerEntry.key}, round: ${playerEntry.value.roundNumber}'),
            Text(
                'prediction: ${playerEntry.value.winsPredicted}, actual: ${playerEntry.value.actualWins}, bonus: ${playerEntry.value.bonus}'),
            Text(
              'round total: ${playerEntry.value.roundTotal}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ]
        ],
      ],
    );
  }
}

class PlayerInput extends StatelessWidget {
  const PlayerInput({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
