import 'package:time_machine/time_machine.dart';

import 'game_records.dart';

class GameSessionToken {
  final List<String> players;
  late final GameRecord records;

  GameSessionToken(this.players) {
    records = GameRecord(startTime: Instant.now(), players: players);
  }
}
