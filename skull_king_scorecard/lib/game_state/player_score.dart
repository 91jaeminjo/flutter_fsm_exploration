class PlayerScore {
  final int winsPredicted;
  final int actualWins;
  final int roundNumber;
  final int bonusPoints;
  late final int totalPoints;
  PlayerScore({
    required this.winsPredicted,
    required this.actualWins,
    required this.roundNumber,
    required this.bonusPoints,
  }) {
    int roundPoints = 0;
    if (winsPredicted == actualWins) {
      if (winsPredicted == 0) {
        if (roundNumber == 10) {
          roundPoints = 200;
        } else {
          roundPoints = roundNumber * 10;
        }
      } else {
        roundPoints = winsPredicted * 10;
      }
    } else {
      if (winsPredicted == 0) {
        if (roundNumber == 10) {
          roundPoints = 200;
        } else {
          roundPoints = roundNumber * 10;
        }
      }
      roundPoints = (winsPredicted - actualWins).abs() * -10;
    }
    totalPoints = roundPoints + bonusPoints;
  }
}