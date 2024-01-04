import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skull_king_scorecard/game_state/game_records.dart';
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
    winsPredicted =
        widget.playerRoundRecord[widget.playerName]?.winsPredicted ?? 0;
    actualWins = widget.playerRoundRecord[widget.playerName]?.actualWins ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(widget.playerName),
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
                                  : widget.roundStarted
                                      ? Colors.grey
                                      : Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                            ),
                            onPressed: widget.roundStarted
                                ? null
                                : (winsPredicted == i || roundNumberIndex == 11)
                                    ? null
                                    : () {
                                        setState(() {
                                          winsPredicted = i;
                                          widget.playerRoundRecord[
                                                  widget.playerName]!
                                              .updateWithValue(
                                                  winsPredicted: i);
                                        });
                                      },
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
                                  : !widget.roundStarted
                                      ? Colors.grey
                                      : Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                            ),
                            onPressed: widget.roundStarted
                                ? (actualWins == i || roundNumberIndex == 11)
                                    ? null
                                    : () {
                                        setState(() {
                                          actualWins = i;
                                          widget.playerRoundRecord[
                                                  widget.playerName]!
                                              .updateWithValue(actualWins: i);
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
              const Text('Bonus'),
              TextField(
                enabled: widget.roundStarted,
                controller: widget.bonusTextController,
                keyboardType: TextInputType.number,
                onChanged: (bonus) {
                  widget.playerRoundRecord[widget.playerName]!
                      .updateWithValue(bonus: int.parse(bonus));
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
