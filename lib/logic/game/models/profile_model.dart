import 'package:equatable/equatable.dart';

class ProfileModel extends Equatable {
  final String name;
  final int age;
  final String salutation;
  final int yearsOfExperience;
  final String jobTitle;

  const ProfileModel({
    required this.name,
    required this.age,
    required this.salutation,
    required this.yearsOfExperience,
    required this.jobTitle,
  });

  @override
  List<Object?> get props => [
        name,
        age,
        salutation,
        yearsOfExperience,
        jobTitle,
      ];
}
