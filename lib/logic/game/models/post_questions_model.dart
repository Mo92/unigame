// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class PostQuestionsModel extends Equatable {
  final String understanding;
  final String struggles;
  final String fairness;
  final String cooperations;
  final String decisions;
  final String enemyAnalytic;
  final String enemyStrategy;
  final String enemyDidManipulate;
  final String performance;
  final String optimization;
  final String suggestions;

  const PostQuestionsModel({
    required this.understanding,
    required this.struggles,
    required this.fairness,
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
        fairness,
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
