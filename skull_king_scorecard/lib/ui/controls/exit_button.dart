import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skull_king_scorecard/ui/browsing/controllers.dart';

class ExitButton extends ConsumerWidget {
  const ExitButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skullKingControl = ref.read(skullKingController);

    return OutlinedButton(
      onPressed: () {
        skullKingControl.exitState();
      },
      child: const Text('Exit'),
    );
  }
}
