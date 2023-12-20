import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:automata/automata.dart';
import 'package:stream_transform/stream_transform.dart';

final StateMachine _fsm = StateMachine.create(
  id: 'skull_king_fsm',
  (g) => g
    ..initial<Home>()
    ..state<Home>(
      builder: (g) => g
        ..onEntry((_) {})
        ..on<StartNewGame, InitGame>()
        ..on<ViewGameHistory, History>(),
    )
    ..state<InitGame>(
      builder: (g) => g
        ..onEntry((_) {})
        ..on<InitGameFinished, Playing>()
        ..on<Exit, Home>(),
    )
    ..state<Playing>(
      builder: (g) => g
        ..onEntry((_) {})
        ..on<GameFinished, Home>()
        ..on<Exit, Home>(),
    )
    ..state<History>(
      builder: (g) => g
        ..onEntry((_) {})
        ..on<Exit, Home>(),
    ),
);

final Stream<Type> myStream = _fsm.stream.map(
  (event) {
    print('active nodes: ${event.activeNodes}');
    print('last node: ${event.activeNodes.last.stateType}');
    return event.activeNodes.last.stateType;
  },
).startWith(Home);

Future<void> main() async {
  // to visualize the fsm:
  // await exportToXStateViz(_fsm);

  runApp(const SkullKingScorecard());
}

class SkullKingScorecard extends StatelessWidget {
  const SkullKingScorecard({super.key});

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

class SkullKingWidget extends StatelessWidget {
  const SkullKingWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: StreamBuilder<Type>(
            stream: myStream,
            builder: (context, snapshot) {
              final state = snapshot.data;
              if (state == null) {
                return Container();
              }
              switch (state) {
                case Home:
                case History:
                  return const HomePage();
                case InitGame:
                  return const InitGamePage();
                case Playing:
                  return const ScorePage();
              }
              // if (state.isInState(Home)) {
              //   return const HomePage();
              // }
              // if (state.isInState(InitGame)) {
              //   return const HomePage();
              // }
              // if (state.isInState(Playing)) {
              //   return const HomePage();
              // }
              // if (state.isInState(History)) {
              //   return const HomePage();
              // }
              return const HomePage();
              // throw UnimplementedError();
            }),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        OutlinedButton(
          onPressed: () {
            _fsm.send(StartNewGame());
          },
          child: const Text('New Game'),
        ),
        OutlinedButton(
          onPressed: () {
            _fsm.send(StartNewGame());
          },
          child: const Text('View History'),
        ),
      ],
    );
  }
}

class ExitButton extends StatelessWidget {
  const ExitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        _fsm.send(Exit());
      },
      child: const Text('Exit'),
    );
  }
}

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

class PlayerSetUp extends StatefulWidget {
  const PlayerSetUp({super.key});

  @override
  State<PlayerSetUp> createState() => _PlayerSetUpState();
}

class _PlayerSetUpState extends State<PlayerSetUp> {
  int numberOfPlayers = 2;
  final players = <String>[];
  late final TextEditingController playerNumberController;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    playerNumberController = TextEditingController(text: '$numberOfPlayers');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text('Enter number of players'),
          Row(
            children: [
              Expanded(
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      if (numberOfPlayers <= 2) {
                        numberOfPlayers--;
                        _formKey.currentState?.validate();
                        numberOfPlayers++;
                        return;
                      }
                      numberOfPlayers--;
                      playerNumberController.text = '$numberOfPlayers';
                      _formKey.currentState?.validate();
                    });
                  },
                  icon: const Icon(Icons.remove),
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: playerNumberController,
                  // initialValue: '$numberOfPlayers',
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: (value) {
                    if (value == null) {
                      return '';
                    }
                    final integerValue = int.parse('$numberOfPlayers');
                    if (integerValue < 2) {
                      return 'value is < 2';
                    }
                    if (integerValue > 8) {
                      return 'value is > 8';
                    }
                  },
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      if (numberOfPlayers >= 8) {
                        numberOfPlayers++;
                        _formKey.currentState?.validate();
                        numberOfPlayers--;
                        return;
                      }
                      numberOfPlayers++;
                      playerNumberController.text = '$numberOfPlayers';
                      _formKey.currentState?.validate();
                    });
                  },
                  icon: const Icon(Icons.add),
                ),
              ),
            ],
          ),
          ...[
            for (int i = 0; i < numberOfPlayers; i++)
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextFormField(
                  initialValue: '',
                  decoration: InputDecoration(
                      labelText: 'Player $i',
                      border: const OutlineInputBorder()),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.name,
                  onSaved: (newValue) {
                    if (newValue == null || newValue.isEmpty) {
                      players.add('Player $i');
                      return;
                    }
                    players.add(newValue);
                  },
                ),
              ),
          ],
          OutlinedButton(
            onPressed: () {
              _formKey.currentState!.validate();
              _formKey.currentState!.save();
              _fsm.send(InitGameFinished(players));
            },
            child: const Text('Start Game'),
          ),
        ],
      ),
    );
  }
}

class ScorePage extends StatelessWidget {
  const ScorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExitButton();
  }
}

// states

class Home implements AutomataState {}

class InitGame implements AutomataState {}

class Playing implements AutomataState {}

class History implements AutomataState {}

// events

class StartNewGame implements AutomataEvent {}

class InitGameFinished implements AutomataEvent {
  final List<String> players;
  const InitGameFinished(this.players);
}

class GameFinished implements AutomataEvent {}

class ViewGameHistory implements AutomataEvent {}

class Exit implements AutomataEvent {}
