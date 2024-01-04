import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/ui.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skullKingControl = ref.read(skullKingController);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        OutlinedButton(
          onPressed: () {
            skullKingControl.startNewGame();
          },
          child: const Text('New Game'),
        ),
        OutlinedButton(
          onPressed: () {},
          child: const Text('View History'),
        ),
      ],
    );
  }
}
