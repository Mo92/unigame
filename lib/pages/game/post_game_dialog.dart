import 'package:flutter/material.dart';
import 'package:shadow_deals/core/helpers.dart';
import 'package:shadow_deals/logic/game/game_bloc.dart';
import 'package:shadow_deals/logic/game/game_event.dart';
import 'package:shadow_deals/logic/game/models/post_questions_model.dart';
import 'package:shadow_deals/pages/game/widgets/conditional_inputs.dart';
import 'package:shadow_deals/pages/game/widgets/understanding_radios.dart';

class PostGameDialog extends StatefulWidget {
  const PostGameDialog({super.key, required this.gameBloc});
  final GameBloc gameBloc;

  @override
  State<PostGameDialog> createState() => _PostGameDialogState();
}

class _PostGameDialogState extends State<PostGameDialog> {
  final _formKey = GlobalKey<FormState>();
  final _gameStrugglesController = TextEditingController();
  final _decisionMaking = TextEditingController();
  final _didYouAnalyzeComputerController = TextEditingController();
  final _didCpuManipulateController = TextEditingController();
  final _optimization = TextEditingController();
  final _suggestions = TextEditingController();
  int understanding = -1;
  int struggles = -1;
  int fairness = -1;
  int cooperations = -1;
  int didAnalyze = -1;
  int howWasEnemy = -1;
  int didCpuManipulate = -1;
  int performance = -1;
  bool showError = false;

  bool get noRadiosSelected =>
      understanding < 0 ||
      struggles < 0 ||
      fairness < 0 ||
      cooperations < 0 ||
      didAnalyze < 0 ||
      howWasEnemy < 0 ||
      didCpuManipulate < 0 ||
      performance < 0;

  void submitData(BuildContext context) {
    if (noRadiosSelected) {
      setState(() {
        showError = true;
      });
      return;
    }
    setState(() {
      showError = false;
    });

    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      final PostQuestionsModel postQuestionsModel = PostQuestionsModel(
        understanding: mapUnderstanding(understanding),
        struggles: mapStruggles(struggles, _gameStrugglesController.text),
        fairness: mapFairness(fairness),
        cooperations: mapCooperations(cooperations),
        decisions: _decisionMaking.text,
        enemyAnalytic:
            mapDidAnalyze(didAnalyze, _didYouAnalyzeComputerController.text),
        enemyStrategy: mapHowWasEnemy(howWasEnemy),
        enemyDidManipulate: mapDidCpuManipulate(
            didCpuManipulate, _didYouAnalyzeComputerController.text),
        performance: mapPerformance(performance),
        optimization: _optimization.text,
        suggestions: _suggestions.text,
      );

      widget.gameBloc.add(SavePostQuestions(postQuestions: postQuestionsModel));
    }
  }

  @override
  void dispose() {
    _gameStrugglesController.dispose();
    _decisionMaking.dispose();
    _didYouAnalyzeComputerController.dispose();
    _didCpuManipulateController.dispose();
    _optimization.dispose();
    _suggestions.dispose();

    super.dispose();
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
                if (showError)
                  ListTile(
                    iconColor: Colors.red,
                    textColor: Colors.red,
                    leading: Icon(Icons.warning),
                    title: Text(
                      'Es wurden nicht alle Felder ausgewählt',
                    ),
                  ),
                SizedBox(height: 32),
                Text('Wie gut haben Sie das Ziel des Experiments verstanden?'),
                SizedBox(height: 16),
                RadioGroupWidget(
                  groupValue: understanding,
                  onChanged: (value) => setState(() => understanding = value!),
                  options: [
                    'Gar nicht',
                    'Wenig',
                    'Mittelmäßig',
                    'Gut',
                    'Sehr gut'
                  ],
                ),
                SizedBox(height: 32),
                Text(
                    'Hatten Sie während des Experiments Schwierigkeiten? Wenn ja, bitte beschreiben.'),
                SizedBox(height: 16),
                ConditionalInputWidget(
                  selectedValue: struggles,
                  onValueChanged: (value) {
                    setState(() {
                      struggles = value!;
                    });
                  },
                  textController: _gameStrugglesController,
                ),
                SizedBox(height: 32),
                Text('Wie fair empfanden Sie das Experiment?'),
                SizedBox(height: 16),
                RadioGroupWidget(
                  groupValue: fairness,
                  onChanged: (value) {
                    setState(() {
                      fairness = value!;
                    });
                  },
                  options: [
                    'Sehr unfair',
                    'Unfair',
                    'Neutral',
                    'Fair',
                    'Sehr fair',
                  ],
                ),
                SizedBox(height: 32),
                Text(
                    'Wie oft haben Sie während des Experiments ehrlich gehandelt?'),
                SizedBox(height: 16),
                RadioGroupWidget(
                  groupValue: cooperations,
                  onChanged: (value) {
                    setState(() {
                      cooperations = value!;
                    });
                  },
                  options: [
                    'Nie',
                    'Selten',
                    'Manchmal',
                    'Oft',
                    'Immer',
                  ],
                ),
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
                  ),
                ),
                SizedBox(height: 32),
                Text(
                    'Haben Sie die Strategie Ihres Gegenspielers bewusst analysiert? Wenn ja, bitte beschreiben'),
                SizedBox(height: 16),
                ConditionalInputWidget(
                  selectedValue: didAnalyze,
                  onValueChanged: (value) {
                    setState(() {
                      didAnalyze = value!;
                    });
                  },
                  textController: _didYouAnalyzeComputerController,
                ),
                SizedBox(height: 32),
                Text(
                    'Wie haben Sie die Strategie Ihres Gegenspielers wahrgenommen?'),
                SizedBox(height: 16),
                RadioGroupWidget(
                  groupValue: howWasEnemy,
                  onChanged: (value) {
                    setState(() {
                      howWasEnemy = value!;
                    });
                  },
                  options: [
                    'Sehr kooperativ',
                    'Kooperativ',
                    'Neutral',
                    'Konkurrenzorientiert',
                    'Sehr konkurrenzorientiert',
                  ],
                ),
                SizedBox(height: 32),
                Text(
                    'Hat Ihr Gegenspieler Ihre Entscheidung beeinflusst? Wenn ja, wie?'),
                SizedBox(height: 16),
                ConditionalInputWidget(
                  selectedValue: didCpuManipulate,
                  onValueChanged: (value) {
                    setState(() {
                      didCpuManipulate = value!;
                    });
                  },
                  textController: _didCpuManipulateController,
                ),
                SizedBox(height: 32),
                Text(
                    'Wie zufrieden sind Sie mit Ihrer Leistung im Experiment?'),
                SizedBox(height: 16),
                RadioGroupWidget(
                  groupValue: performance,
                  onChanged: (value) {
                    setState(() {
                      performance = value!;
                    });
                  },
                  options: [
                    'Sehr unzufrieden',
                    'Unzufrieden',
                    'Neutral',
                    'Zufrieden',
                    'Sehr zufrieden',
                  ],
                ),
                SizedBox(height: 32),
                Text(
                    'Haben Sie Verbesserungsvorschläge für zukünfitge Experimente?'),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _optimization,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Bitte beschreiben',
                    ),
                  ),
                ),
                SizedBox(height: 32),
                Text('Haben Sie weiter Anmerkungen?'),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _suggestions,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Bitte beschreiben',
                    ),
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
                  onPressed: () => submitData(context),
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
