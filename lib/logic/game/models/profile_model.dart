import 'package:equatable/equatable.dart';

class ProfileModel extends Equatable {
  final String name; // Spielername
  final int age; // Alter
  final String salutation; // Anrede
  final int yearsOfExperience; // Berufserfahrung
  final String jobTitle; // Beruf
  final String gamePlayed; // Schon gespielt

  const ProfileModel({
    required this.name,
    required this.age,
    required this.salutation,
    required this.yearsOfExperience,
    required this.jobTitle,
    required this.gamePlayed,
  });

  @override
  List<Object?> get props => [
        name,
        age,
        salutation,
        yearsOfExperience,
        jobTitle,
        gamePlayed,
      ];
}
