import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/game_state.dart';

import 'configure.dart';

int maxRounds = 2;
Map<String, List<PlayerScore>> gameRecord = {};
Map<String, List<int>> gamePredictionRecord = {};
Map<String, List<int>> gameWinRecord = {};
Map<String, List<int>> gameRoundBonusRecord = {};

List<String> allPlayers = [];

Future<void> main() async {
  // to visualize the fsm:
  // await exportToXStateViz(_fsm);

  runApp(configure());
}
