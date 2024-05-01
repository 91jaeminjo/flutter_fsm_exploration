import 'dart:async';

import 'package:flutter/material.dart';

import 'configure.dart';

Future<void> main() async {
  // to visualize the fsm:
  // await exportToXStateViz(_fsm);

  runApp(configure());
}
