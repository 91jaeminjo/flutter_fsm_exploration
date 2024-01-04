import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/ui/browsing.dart';
import '/ui/controls.dart';
import '/ui/state.dart';

import '/game_state.dart';

class SkullKingWidget extends ConsumerWidget {
  const SkullKingWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skullKingControl = ref.read(skullKingController);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: StreamBuilder<GameState>(
            stream: skullKingControl.stateStream,
            builder: (context, snapshot) {
              final gameState = snapshot.data;
              if (gameState == null) {
                return Container();
              }
              switch (gameState.state) {
                case Home:
                case History:
                  return const Dashboard();
                case InitGame:
                  return const InitGamePage();
                case Playing:
                  return ScorePage(gameState.session);
              }
              return const Dashboard();
            }),
      ),
    );
  }
}
