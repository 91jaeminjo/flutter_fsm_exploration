import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skull_king_scorecard/game_state/game_records.dart';
import 'package:skull_king_scorecard/ui/browsing/controllers.dart';
import 'package:skull_king_scorecard/ui/ui_extensions/interleaved_widgets.dart';

class PlayerScoreCard extends StatefulWidget {
  final String playerName;
  final int roundNumber;
  final bool roundStarted;
  final TextEditingController bonusTextController;
  final Map<String, RoundRecord> playerRoundRecord;
  const PlayerScoreCard({
    required this.playerName,
    required this.roundNumber,
    required this.roundStarted,
    required this.bonusTextController,
    required this.playerRoundRecord,
    super.key,
  });

  @override
  State<PlayerScoreCard> createState() => _PlayerScoreCardState();
}

class _PlayerScoreCardState extends State<PlayerScoreCard> {
  late int winsPredicted;
  late int actualWins;
  late int roundNumberIndex;

  @override
  void initState() {
    super.initState();
    roundNumberIndex = widget.roundNumber - 1;
    // print(
    //     'inside score card init: ${widget.playerRoundRecord[widget.playerName]}');
    // print('inside score card init: ${widget.playerRoundRecord[widget.playerName]}');
    winsPredicted =
        widget.playerRoundRecord[widget.playerName]?.winsPredicted ?? 0;
    actualWins = widget.playerRoundRecord[widget.playerName]?.actualWins ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    // print('inside score card: ${widget.playerRoundRecord}');
    // print('inside score card: ${widget.playerRoundRecord[widget.playerName]}');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.playerName),
              PredictionInput(
                roundNumber: widget.roundNumber,
                playerName: widget.playerName,
                winsPredicted: winsPredicted,
                actualWins: actualWins,
                enabled: !widget.roundStarted,
                key: ValueKey(
                  'Prediction input ${widget.roundNumber} ${widget.playerName}',
                ),
              ),
              WinsInput(
                roundNumber: widget.roundNumber,
                playerName: widget.playerName,
                winsPredicted: winsPredicted,
                actualWins: actualWins,
                enabled: widget.roundStarted,
                key: ValueKey(
                  'Wins input ${widget.roundNumber} ${widget.playerName}',
                ),
              ),
              const Text('Bonus'),
              TextField(
                enabled: widget.roundStarted,
                controller: widget.bonusTextController,
                keyboardType: TextInputType.number,
                onChanged: (bonus) {
                  if (widget.playerRoundRecord[widget.playerName] == null) {
                    widget.playerRoundRecord[widget.playerName] = RoundRecord(
                        roundNumber: widget.roundNumber,
                        player: widget.playerName,
                        winsPredicted: winsPredicted,
                        actualWins: actualWins,
                        bonus: int.parse(bonus));
                  } else {
                    widget.playerRoundRecord[widget.playerName]!
                        .updateWithValue(bonus: int.parse(bonus));
                  }
                },
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PredictionInput extends ConsumerStatefulWidget {
  final int roundNumber;
  final String playerName;
  final int winsPredicted;
  final int actualWins;
  final bool enabled;
  const PredictionInput({
    required this.roundNumber,
    required this.playerName,
    required this.winsPredicted,
    required this.actualWins,
    required this.enabled,
    super.key,
  });

  @override
  ConsumerState<PredictionInput> createState() => _PredictionInputState();
}

class _PredictionInputState extends ConsumerState<PredictionInput> {
  late int winsPredicted;

  @override
  void initState() {
    super.initState();
    // print('inside pred init. widget.winsPredicted: ${widget.winsPredicted}');
    winsPredicted = widget.winsPredicted;
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(skullKingController);
    return Column(
      children: [
        const Text('Prediction'),
        Wrap(
          alignment: WrapAlignment.start,
          children: [
            if (widget.roundNumber < 11)
              ...[
                for (int i = 0; i <= widget.roundNumber; i++)
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: const CircleBorder(),
                        backgroundColor: winsPredicted == i
                            ? Colors.white
                            : !widget.enabled
                                ? Colors.grey
                                : Theme.of(context).colorScheme.inversePrimary,
                      ),
                      onPressed: widget.enabled
                          ? (winsPredicted == i)
                              ? null
                              : () {
                                  setState(() {
                                    winsPredicted = i;
                                    // widget.playerRoundRecord[widget.playerName]!
                                    //     .updateWithValue(winsPredicted: i);
                                    controller.recordPlayerPredictions(
                                        player: widget.playerName,
                                        prediction: winsPredicted);
                                  });
                                }
                          : null,
                      child: Text('$i'),
                    ),
                  ),
              ].interleave(
                const SizedBox(
                  width: 4,
                ),
              )
          ],
        ),
      ],
    );
  }
}

class WinsInput extends ConsumerStatefulWidget {
  final int roundNumber;
  final String playerName;
  final int winsPredicted;
  final int actualWins;
  final bool enabled;
  const WinsInput({
    required this.roundNumber,
    required this.playerName,
    required this.winsPredicted,
    required this.actualWins,
    required this.enabled,
    super.key,
  });

  @override
  ConsumerState<WinsInput> createState() => _WinsInputState();
}

class _WinsInputState extends ConsumerState<WinsInput> {
  late int actualWins;

  @override
  void initState() {
    super.initState();
    // print('inside wins init. widget.actualWins: ${widget.actualWins}');
    actualWins = widget.actualWins;
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(skullKingController);
    return Column(
      children: [
        const Text('Actual'),
        Wrap(
          alignment: WrapAlignment.start,
          children: [
            if (widget.roundNumber < 11)
              ...[
                for (int i = 0; i <= widget.roundNumber; i++)
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: const CircleBorder(),
                        backgroundColor: actualWins == i
                            ? Colors.white
                            : !widget.enabled
                                ? Colors.grey
                                : Theme.of(context).colorScheme.inversePrimary,
                      ),
                      onPressed: widget.enabled
                          ? (actualWins == i)
                              ? null
                              : () {
                                  setState(() {
                                    actualWins = i;
                                    // widget.playerRoundRecord[widget.playerName]!
                                    //     .updateWithValue(actualWins: i);
                                    controller.recordPlayerWins(
                                        player: widget.playerName,
                                        wins: actualWins);
                                  });
                                }
                          : null,
                      child: Text('$i'),
                    ),
                  ),
              ].interleave(
                const SizedBox(
                  width: 4,
                ),
              )
          ],
        )
      ],
    );
  }
}
