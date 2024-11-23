import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unigame/logic/game/game_bloc.dart';
import 'package:unigame/logic/game/game_event.dart';
import 'package:unigame/logic/game/models/profile_model.dart';

class ProfileDialog extends StatefulWidget {
  const ProfileDialog({super.key});

  @override
  State<ProfileDialog> createState() => _ProfileDialogState();
}

class _ProfileDialogState extends State<ProfileDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  int? selectedSalutation;

  final ProfileModel profileDummy = ProfileModel(
    name: 'Testmann',
    age: 23,
    salutation: 'M',
    yearsOfExperience: 6,
    jobTitle: 'Student',
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Dialog(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text('Stell dich vor bevor du spielst.'),
                  SizedBox(height: 16),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              Radio<int>(
                                  value: 0,
                                  groupValue: selectedSalutation,
                                  onChanged: (index) {
                                    setState(() {
                                      selectedSalutation = index!;
                                    });
                                  }),
                              Expanded(
                                child: Text('Männlich'),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              Radio(
                                  value: 1,
                                  groupValue: selectedSalutation,
                                  onChanged: (index) {
                                    setState(() {
                                      selectedSalutation = index!;
                                    });
                                  }),
                              Expanded(child: Text('Weiblich'))
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              Radio(
                                  value: 2,
                                  groupValue: selectedSalutation,
                                  onChanged: (index) {
                                    setState(() {
                                      selectedSalutation = index!;
                                    });
                                  }),
                              Expanded(child: Text('Divers'))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Wie heißt du?',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: TextEditingController(),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Wie alt bist du',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: TextEditingController(),
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Womit verdienst du dein Brot',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: TextEditingController(),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Wie lang machst du das schon (in Jahren)',
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      BlocProvider.of<GameBloc>(context).add(
                        SaveProfile(profile: profileDummy),
                      );
                    },
                    child: Text('Speichern'),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
