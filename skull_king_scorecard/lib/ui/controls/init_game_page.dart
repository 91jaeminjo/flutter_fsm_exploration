import 'package:flutter/material.dart';

import 'exit_button.dart';
import 'player_set_up.dart';

class InitGamePage extends StatelessWidget {
  const InitGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          PlayerSetUp(),
          ExitButton(),
        ],
      ),
    );
  }
}
