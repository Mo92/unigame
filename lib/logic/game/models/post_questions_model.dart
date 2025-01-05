import 'package:equatable/equatable.dart';

class PostQuestionsModel extends Equatable {
  final String understanding; // Spielverständnis
  final String struggles; // Schwierigkeiten
  final String cooperations; // Spieler Strategie
  final String decisions; // Sp. Strategie Begründung
  final String enemyAnalytic; // Dealer analysiert
  final String enemyStrategy; // Dealer Strategie
  final String enemyDidManipulate; // Wurde Spieler beeinflusst
  final String performance; // Spieler Leistung
  final String optimization; // Vorschläge
  final String suggestions; // Anmerkungen

  const PostQuestionsModel({
    required this.understanding,
    required this.struggles,
    required this.cooperations,
    required this.decisions,
    required this.enemyAnalytic,
    required this.enemyStrategy,
    required this.enemyDidManipulate,
    required this.performance,
    required this.optimization,
    required this.suggestions,
  });

  @override
  List<Object> get props => [
        understanding,
        struggles,
        cooperations,
        decisions,
        enemyAnalytic,
        enemyStrategy,
        enemyDidManipulate,
        performance,
        optimization,
        suggestions,
      ];
}
