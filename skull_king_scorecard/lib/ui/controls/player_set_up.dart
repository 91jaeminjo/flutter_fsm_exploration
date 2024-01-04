import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skull_king_scorecard/ui/browsing/controllers.dart';

class PlayerSetUp extends ConsumerStatefulWidget {
  const PlayerSetUp({super.key});

  @override
  ConsumerState<PlayerSetUp> createState() => _PlayerSetUpState();
}

class _PlayerSetUpState extends ConsumerState<PlayerSetUp> {
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
    final skullKingControl = ref.read(skullKingController);

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
                    return '';
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
          for (int i = 0; i < numberOfPlayers; i++)
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextFormField(
                initialValue: '',
                decoration: InputDecoration(
                    labelText: 'Player $i', border: const OutlineInputBorder()),
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
          OutlinedButton(
            onPressed: () {
              _formKey.currentState!.validate();
              _formKey.currentState!.save();
              skullKingControl.completeGameSetUp(players);
            },
            child: const Text('Start Game'),
          ),
        ],
      ),
    );
  }
}
