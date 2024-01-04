import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/game_state.dart';
import '/ui.dart';

import 'skull_king.dart';

Widget configure() {
  final skullKingControl = SkullKingController(SkullKingState());

  return ProviderScope(
      overrides: [skullKingController.overrideWithValue(skullKingControl)],
      child: const SkullKingScorecardApp());
}
