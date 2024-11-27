import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadow_deals/core/text_validators.dart';
import 'package:shadow_deals/logic/game/game_bloc.dart';
import 'package:shadow_deals/logic/game/game_event.dart';
import 'package:shadow_deals/logic/game/models/profile_model.dart';
import 'package:shadow_deals/pages/game/widgets/conditional_inputs.dart';

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
  final _gamePlayedController = TextEditingController();

  int selectedSalutation = 0;
  int gamePlayed = 0;

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
                  Text('Stell dich vor, bevor du Spielst:'),
                  SizedBox(height: 16),
                  Text('Was ist dein Geschlecht?'),
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
                      labelText: 'Wie lautet dein Spielername?',
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
                      labelText: 'Wie alt bist du?',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _jobController,
                    validator: Validators.required,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText:
                          'Was machst du beruflich? Und in welchem Bereich? ',
                      helperText:
                          '(Zb. Student der Wirttschaftswissenschaften, Junior Analyst im Controlling)',
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
                      labelText: 'Wieviele Jahre machst du das schon?',
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                      'Haben Sie das Spiel schon einmal gespielt? Wenn ja, wie oft?'),
                  SizedBox(height: 8),
                  ConditionalInputWidget(
                    selectedValue: gamePlayed,
                    onValueChanged: (value) {
                      setState(() {
                        gamePlayed = value!;
                      });
                    },
                    textController: _gamePlayedController,
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
        gamePlayed: gamePlayed == 1 ? _gamePlayedController.text : 'Nein',
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
