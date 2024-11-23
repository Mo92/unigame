import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unigame/core/text_validators.dart';
import 'package:unigame/logic/game/game_bloc.dart';
import 'package:unigame/logic/game/game_event.dart';
import 'package:unigame/logic/game/models/profile_model.dart';

class ProfileDialog extends StatefulWidget {
  const ProfileDialog({required this.gameBloc, super.key});
  final GameBloc gameBloc;

  @override
  State<ProfileDialog> createState() => _ProfileDialogState();
}

class _ProfileDialogState extends State<ProfileDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _jobController = TextEditingController();
  final _yearsOfExperienceController = TextEditingController();

  int selectedSalutation = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Dialog(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    validator: Validators.required,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Wie heißt du?',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _ageController,
                    validator: Validators.required,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                    ],
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Wie alt bist du',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _jobController,
                    validator: Validators.required,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Womit verdienst du dein Brot',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _yearsOfExperienceController,
                    validator: Validators.required,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                    ],
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Wie lang machst du das schon (in Jahren)',
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => save(context),
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

  save(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      final profile = ProfileModel(
        name: _nameController.text,
        age: int.parse(_ageController.text),
        salutation: getSalutation(),
        yearsOfExperience: int.parse(_yearsOfExperienceController.text),
        jobTitle: _jobController.text,
      );

      widget.gameBloc.add(SaveProfile(profile: profile));
      Navigator.of(context).pop();
    }
  }

  String getSalutation() {
    switch (selectedSalutation) {
      case 0:
        return 'M';
      case 1:
        return 'F';
      default:
        return 'D';
    }
  }
}
