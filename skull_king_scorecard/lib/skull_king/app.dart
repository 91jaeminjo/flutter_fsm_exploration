import 'package:flutter/material.dart';

import '/ui.dart';

class SkullKingScorecardApp extends StatelessWidget {
  const SkullKingScorecardApp({super.key});

  static const title = 'Skull King Scorecard';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SkullKingWidget(title: title),
    );
  }
}
