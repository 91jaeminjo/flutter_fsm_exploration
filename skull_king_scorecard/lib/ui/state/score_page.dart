import 'package:flutter/material.dart';
import 'package:skull_king_scorecard/game_state/game_records.dart';

import '/game_state.dart';
import '/ui/controls.dart';

import 'player_score_card.dart';

class ScorePage extends StatefulWidget {
  final GameSessionToken gameSessionToken;
  const ScorePage(this.gameSessionToken, {super.key});

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  int roundNumber = 1;
  bool roundStarted = false;
  late int roundNumberIndex;

  @override
  void initState() {
    super.initState();
    roundNumberIndex = roundNumber - 1;
  }

  @override
  Widget build(BuildContext context) {
    final players = widget.gameSessionToken.players;
    final gameRecordList = widget.gameSessionToken.records.recordList;
    final textControllers = <String, TextEditingController>{};
    // final gamePredictionRecord = <String, int>{};
    // final gameWinRecord = <String, int>{};
    // final gameRoundBonusRecord = <String, int>{};
    for (String player in players) {
      textControllers[player] = TextEditingController();
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          if (roundNumber != 11)
            Text(
              'Round $roundNumber',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                height: 4,
              ),
            ),
          if (roundNumber != 1) PlayerSummary(gameRecordList, roundNumber),
          if (roundNumber != 11)
            for (String player in players)
              PlayerScoreCard(
                playerName: player,
                roundNumber: roundNumber,
                roundStarted: roundStarted,
                bonusTextController: textControllers[player]!,
                playerRoundRecord: gameRecordList[roundNumber],
                key: ValueKey(player),
              ),
          if (roundNumber <= 10)
            !roundStarted
                ? OutlinedButton(
                    onPressed: () {
                      setState(() {
                        if (roundNumber <= 10) {
                          roundStarted = !roundStarted;
                        }
                      });
                    },
                    child: const Text('Start Round'),
                  )
                : OutlinedButton(
                    onPressed: () {
                      setState(() {
                        if (roundNumber <= 10) {
                          roundStarted = !roundStarted;
                          roundNumber++;
                          textControllers.values.map((e) {
                            e.clear();
                          });
                        }
                      });
                    },
                    child: const Text('End Round'),
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
