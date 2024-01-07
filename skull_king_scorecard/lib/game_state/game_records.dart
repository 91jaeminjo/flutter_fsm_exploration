import 'package:time_machine/time_machine.dart';

class GameRecord {
  final Instant startTime;
  final List<Map<String, RoundRecord>> recordList = [];

  GameRecord({required List<String> players}) : startTime = Instant.now() {
    for (int i = 0; i < 10; i++) {
      recordList.add({});
      for (String player in players) {
        recordList[i][player] = RoundRecord(
          roundNumber: i + 1,
          player: player,
          winsPredicted: 0,
          actualWins: 0,
          bonus: 0,
        );
      }
    }
  }

  bool addRecord(Map<String, RoundRecord> record) {
    if (recordList.length > 9) {
      return false;
    }
    recordList.add(record);
    return true;
  }

  bool modifyRoundRecord(
      {required int roundNumber, required Map<String, RoundRecord> record}) {
    if (roundNumber < 0 || roundNumber > 9) {
      return false;
    }
    recordList[roundNumber] = record;
    return true;
  }
}

class RoundRecord {
  final int roundNumber;
  final String player;
  final int winsPredicted;
  final int actualWins;
  final int bonus;

  late final bool win;
  late final int roundTotal;

  RoundRecord({
    required this.roundNumber,
    required this.player,
    required this.winsPredicted,
    required this.actualWins,
    required this.bonus,
  }) {
    final bool zeroPredicted = winsPredicted == 0;
    final int roundPoints = roundNumber * 10;
    win = actualWins == winsPredicted;
    roundTotal = win
        // win
        ? (zeroPredicted ? (roundPoints + bonus) : (20 * winsPredicted + bonus))
        // loss
        : (zeroPredicted
            ? (-1 * roundPoints)
            : (-1 * (winsPredicted - actualWins).abs()));
  }

  RoundRecord updateWithValue(
      {int? winsPredicted, int? actualWins, int? bonus}) {
    return RoundRecord(
      roundNumber: roundNumber,
      player: player,
      winsPredicted: winsPredicted ?? this.winsPredicted,
      actualWins: actualWins ?? this.actualWins,
      bonus: bonus ?? this.bonus,
    );
  }
}
