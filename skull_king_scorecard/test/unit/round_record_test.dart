import 'package:skull_king_scorecard/game_state/game_records.dart';
import 'package:test/test.dart';

void main() {
  late final RoundRecord record;

  group('Round 1', () {
    test('win with 0 prediction gains round number times 10 (10)', () {});
  });

  group('Round 2', () {});

  group('Round 3', () {});

  group('Round 4', () {});

  group('Round 5', () {});

  group('Round 6', () {});

  group('Round 7', () {});

  group('Round 8', () {});

  group('Round 9', () {});

  group('Round 10', () {});

  group('Win with 0 prediction', () {
    test('gains round number times 10', () {
      for (int round = 1; round < 11; round++) {
        final roundRecord = RoundRecord(
          roundNumber: round,
          player: 'Test player',
          winsPredicted: 0,
          actualWins: 0,
          bonus: 0,
        );
        expect(roundRecord.roundTotal, equals(roundRecord.roundNumber * 10));
      }
    });
  });

  group('Loss with 0 prediction', () {
    test('loses round number times 10', () {
      for (int round = 1; round < 11; round++) {
        final roundRecord = RoundRecord(
          roundNumber: round,
          player: 'Test player',
          winsPredicted: 0,
          actualWins: round,
          bonus: 0,
        );
        expect(
            roundRecord.roundTotal, equals(-1 * roundRecord.roundNumber * 10));
      }
    });
  });

  group('Win with non-0 prediction', () {
    test('gains round number times 20', () {
      for (int round = 1; round < 11; round++) {
        final roundRecord = RoundRecord(
          roundNumber: round,
          player: 'Test player',
          winsPredicted: round,
          actualWins: round,
          bonus: 0,
        );
        expect(roundRecord.roundTotal, equals(roundRecord.actualWins * 20));
      }
    });
  });

  group('Loss with non-0 prediction', () {
    test('loses abs(prediction - actual) times 10', () {
      for (int round = 1; round < 11; round++) {
        final roundRecord = RoundRecord(
          roundNumber: round,
          player: 'Test player',
          winsPredicted: round,
          actualWins: 0,
          bonus: 0,
        );
        expect(
            roundRecord.roundTotal,
            equals(-1 *
                (roundRecord.actualWins - roundRecord.winsPredicted).abs()));
      }
    });
  });
}
