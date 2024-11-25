import 'package:flutter/material.dart';
import 'package:unigame/core/text_validators.dart';
import 'package:unigame/logic/game/game_bloc.dart';

class PostGameDialog extends StatefulWidget {
  const PostGameDialog({super.key, required this.gameBloc});
  final GameBloc gameBloc;

  @override
  State<PostGameDialog> createState() => _PostGameDialogState();
}

class _PostGameDialogState extends State<PostGameDialog> {
  final _formKey = GlobalKey<FormState>();
  final _gameStruggles = TextEditingController();
  final _decisionMaking = TextEditingController();
  final _didYouAnalyzeComputer = TextEditingController();
  final _didCpuManipulate = TextEditingController();
  final _suggestions = TextEditingController();
  final _miscIdeas = TextEditingController();
  int understanding = -1;
  int struggles = -1;
  int fairness = -1;
  int cooperations = -1;
  int didAnalyze = -1;
  int howWasEnemy = -1;
  int didCpuManipulate = -1;
  int performance = -1;

  Widget _buildUnderstandingRadio(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Radio<int>(
                  value: 0,
                  groupValue: understanding,
                  onChanged: (index) {
                    setState(() {
                      understanding = index!;
                    });
                  }),
              Expanded(
                child: Text('Gar nicht'),
              )
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Radio<int>(
                  value: 1,
                  groupValue: understanding,
                  onChanged: (index) {
                    setState(() {
                      understanding = index!;
                    });
                  }),
              Expanded(
                child: Text('Wenig'),
              )
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Radio<int>(
                  value: 2,
                  groupValue: understanding,
                  onChanged: (index) {
                    setState(() {
                      understanding = index!;
                    });
                  }),
              Expanded(
                child: Text('Mittelmäßig'),
              )
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Radio<int>(
                  value: 3,
                  groupValue: understanding,
                  onChanged: (index) {
                    setState(() {
                      understanding = index!;
                    });
                  }),
              Expanded(
                child: Text('Gut'),
              )
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Radio<int>(
                  value: 4,
                  groupValue: understanding,
                  onChanged: (index) {
                    setState(() {
                      understanding = index!;
                    });
                  }),
              Expanded(
                child: Text('Sehr gut'),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGameStruggles(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Radio<int>(
                  value: 0,
                  groupValue: struggles,
                  onChanged: (index) {
                    setState(() {
                      struggles = index!;
                    });
                  }),
              Expanded(
                child: Text('Ja'),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Radio<int>(
                  value: 1,
                  groupValue: struggles,
                  onChanged: (index) {
                    setState(() {
                      struggles = index!;
                    });
                  }),
              Expanded(
                child: Text('Nein'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFairness(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Radio<int>(
                  value: 0,
                  groupValue: fairness,
                  onChanged: (index) {
                    setState(() {
                      fairness = index!;
                    });
                  }),
              Expanded(
                child: Text('Sehr unfair'),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Radio<int>(
                  value: 1,
                  groupValue: fairness,
                  onChanged: (index) {
                    setState(() {
                      fairness = index!;
                    });
                  }),
              Expanded(
                child: Text('Unfair'),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Radio<int>(
                  value: 2,
                  groupValue: fairness,
                  onChanged: (index) {
                    setState(() {
                      fairness = index!;
                    });
                  }),
              Expanded(
                child: Text('Neutral'),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Radio<int>(
                  value: 3,
                  groupValue: fairness,
                  onChanged: (index) {
                    setState(() {
                      fairness = index!;
                    });
                  }),
              Expanded(
                child: Text('Fair'),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Radio<int>(
                  value: 4,
                  groupValue: fairness,
                  onChanged: (index) {
                    setState(() {
                      fairness = index!;
                    });
                  }),
              Expanded(
                child: Text('Sehr fair'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCooperations(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Radio<int>(
                  value: 0,
                  groupValue: cooperations,
                  onChanged: (index) {
                    setState(() {
                      cooperations = index!;
                    });
                  }),
              Expanded(
                child: Text('Nie'),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Radio<int>(
                  value: 1,
                  groupValue: cooperations,
                  onChanged: (index) {
                    setState(() {
                      cooperations = index!;
                    });
                  }),
              Expanded(
                child: Text('Selten'),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Radio<int>(
                  value: 2,
                  groupValue: cooperations,
                  onChanged: (index) {
                    setState(() {
                      cooperations = index!;
                    });
                  }),
              Expanded(
                child: Text('Manchmal'),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Radio<int>(
                  value: 3,
                  groupValue: cooperations,
                  onChanged: (index) {
                    setState(() {
                      cooperations = index!;
                    });
                  }),
              Expanded(
                child: Text('Oft'),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Radio<int>(
                  value: 4,
                  groupValue: cooperations,
                  onChanged: (index) {
                    setState(() {
                      cooperations = index!;
                    });
                  }),
              Expanded(
                child: Text('Immer'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGameAnalyzer(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Radio<int>(
                  value: 0,
                  groupValue: didAnalyze,
                  onChanged: (index) {
                    setState(() {
                      didAnalyze = index!;
                    });
                  }),
              Expanded(
                child: Text('Ja'),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Radio<int>(
                  value: 1,
                  groupValue: didAnalyze,
                  onChanged: (index) {
                    setState(() {
                      didAnalyze = index!;
                    });
                  }),
              Expanded(
                child: Text('Nein'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHowWasEnemy(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Radio<int>(
                  value: 0,
                  groupValue: howWasEnemy,
                  onChanged: (index) {
                    setState(() {
                      howWasEnemy = index!;
                    });
                  }),
              Expanded(
                child: Text('Sehr kooperativ'),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Radio<int>(
                  value: 1,
                  groupValue: howWasEnemy,
                  onChanged: (index) {
                    setState(() {
                      howWasEnemy = index!;
                    });
                  }),
              Expanded(
                child: Text('Kooperativ'),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Radio<int>(
                  value: 2,
                  groupValue: howWasEnemy,
                  onChanged: (index) {
                    setState(() {
                      howWasEnemy = index!;
                    });
                  }),
              Expanded(
                child: Text('Neutral'),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Radio<int>(
                  value: 3,
                  groupValue: howWasEnemy,
                  onChanged: (index) {
                    setState(() {
                      howWasEnemy = index!;
                    });
                  }),
              Expanded(
                child: Text('Konkurrenzorientiert'),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Radio<int>(
                  value: 4,
                  groupValue: howWasEnemy,
                  onChanged: (index) {
                    setState(() {
                      howWasEnemy = index!;
                    });
                  }),
              Expanded(
                child: Text('Sehr konkurrenzorientiert'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDidCpuManipulate(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Radio<int>(
                  value: 0,
                  groupValue: didCpuManipulate,
                  onChanged: (index) {
                    setState(() {
                      didCpuManipulate = index!;
                    });
                  }),
              Expanded(
                child: Text('Ja'),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Radio<int>(
                  value: 1,
                  groupValue: didCpuManipulate,
                  onChanged: (index) {
                    setState(() {
                      didCpuManipulate = index!;
                    });
                  }),
              Expanded(
                child: Text('Nein'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPerformance(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Radio<int>(
                  value: 0,
                  groupValue: performance,
                  onChanged: (index) {
                    setState(() {
                      performance = index!;
                    });
                  }),
              Expanded(
                child: Text('Sehr unzufrieden'),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Radio<int>(
                  value: 1,
                  groupValue: performance,
                  onChanged: (index) {
                    setState(() {
                      performance = index!;
                    });
                  }),
              Expanded(
                child: Text('Unzufrieden'),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Radio<int>(
                  value: 2,
                  groupValue: performance,
                  onChanged: (index) {
                    setState(() {
                      performance = index!;
                    });
                  }),
              Expanded(
                child: Text('Neutral'),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Radio<int>(
                  value: 3,
                  groupValue: performance,
                  onChanged: (index) {
                    setState(() {
                      performance = index!;
                    });
                  }),
              Expanded(
                child: Text('Zufrieden'),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Radio<int>(
                  value: 4,
                  groupValue: performance,
                  onChanged: (index) {
                    setState(() {
                      performance = index!;
                    });
                  }),
              Expanded(
                child: Text('Sehr zufrieden'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Vielen Dank für Ihre Teilnahme und Ihre Zeit. Ihre Antworten sind für unser wissenschaftliches Experiment, sehr wertvoll! Darum bitten wir Sie, die folgenden Fragen zu beantworten. Anschließend können Sie Ihre Gesamtleistung im Spiel begutachten.',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                SizedBox(height: 32),
                Text('Wie gut haben Sie das Ziel des Experiments verstanden?'),
                SizedBox(height: 16),
                _buildUnderstandingRadio(context),
                SizedBox(height: 32),
                Text(
                    'Hatten Sie während des Experiments Schwierigkeiten? Wenn ja, bitte beschreiben.'),
                SizedBox(height: 16),
                _buildGameStruggles(context),
                if (struggles == 0)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _gameStruggles,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Bitte beschreiben',
                      ),
                      validator: struggles == 0 ? Validators.required : null,
                    ),
                  ),
                SizedBox(height: 32),
                Text('Wie fair empfanden Sie das Experiment?'),
                SizedBox(height: 16),
                _buildFairness(context),
                SizedBox(height: 32),
                Text('Wie oft haben Sie während des Experiments kooperiert?'),
                SizedBox(height: 16),
                _buildCooperations(context),
                SizedBox(height: 32),
                Text('Warum haben Sie sich so entschieden?'),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _decisionMaking,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Bitte beschreiben',
                    ),
                    validator: Validators.required,
                  ),
                ),
                SizedBox(height: 32),
                Text(
                    'Haben Sie die Strategie Ihres Gegenspielers bewusst analysiert? Wenn ja, bitte beschreiben'),
                SizedBox(height: 16),
                _buildGameAnalyzer(context),
                if (didAnalyze == 0)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _didYouAnalyzeComputer,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Bitte beschreiben',
                      ),
                      validator: didAnalyze == 0 ? Validators.required : null,
                    ),
                  ),
                SizedBox(height: 32),
                Text(
                    'Wie haben Sie die Strategie Ihres Gegenspielers wahrgenommen?'),
                SizedBox(height: 16),
                _buildHowWasEnemy(context),
                SizedBox(height: 32),
                Text(
                    'Hat Ihr Gegenspieler Ihre Entscheidung beeinflusst? Wenn ja, wie?'),
                SizedBox(height: 16),
                _buildDidCpuManipulate(context),
                if (didCpuManipulate == 0)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _didCpuManipulate,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Bitte beschreiben',
                      ),
                      validator:
                          didCpuManipulate == 0 ? Validators.required : null,
                    ),
                  ),
                SizedBox(height: 32),
                Text(
                    'Wie zufrieden sind Sie mit Ihrer Leistung im Experiment?'),
                SizedBox(height: 16),
                _buildPerformance(context),
                SizedBox(height: 32),
                Text(
                    'Haben Sie Verbesserungsvorschläge für zukünfitge Experimente?'),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _suggestions,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Bitte beschreiben',
                    ),
                    validator: Validators.required,
                  ),
                ),
                SizedBox(height: 32),
                Text('Haben Sie weiter Anmerkungen?'),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _miscIdeas,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Bitte beschreiben',
                    ),
                    validator: Validators.required,
                  ),
                ),
                SizedBox(height: 48),
                Text(
                  'Einverständniserklärung:',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.left,
                ),
                Text(
                    'Durch das Abesenden dieses Fragebogens erkläre ich mich damit einverstanden, dass meine Daten analysiert und ausschließlich zu wissenschaftlichen Zwecken verwendet werden.'),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () => print('Gaga oulala'),
                  child: Text('Absenden'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
