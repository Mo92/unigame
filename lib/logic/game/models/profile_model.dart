// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  ProfileModel copyWith({
    String? name,
    int? age,
    String? salutation,
    int? yearsOfExperience,
    String? jobTitle,
    String? gamePlayed,
  }) {
    return ProfileModel(
      name: name ?? this.name,
      age: age ?? this.age,
      salutation: salutation ?? this.salutation,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      jobTitle: jobTitle ?? this.jobTitle,
      gamePlayed: gamePlayed ?? this.gamePlayed,
    );
  }
}
