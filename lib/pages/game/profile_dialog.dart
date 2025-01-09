import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadow_deals/core/text_validators.dart';
import 'package:shadow_deals/logic/game/game_bloc.dart';
import 'package:shadow_deals/logic/game/game_event.dart';
import 'package:shadow_deals/logic/game/models/profile_model.dart';
import 'package:shadow_deals/pages/game/widgets/conditional_inputs.dart';
import 'package:shadow_deals/pages/game/widgets/responsive_selection_list.dart';

class ProfileDialog extends StatefulWidget {
  const ProfileDialog({
    required this.gameBloc,
    required this.usePlayerTerm,
    super.key,
  });

  final GameBloc gameBloc;
  final bool usePlayerTerm;

  @override
  State<ProfileDialog> createState() => _ProfileDialogState();
}

class _ProfileDialogState extends State<ProfileDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _yearsOfExperienceController = TextEditingController();
  final _gamePlayedController = TextEditingController();

  int selectedSalutation = 0;
  int gamePlayed = 0;
  int selectedJob = -1;
  int selectedJobDefiniton = 0;

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Stell dich vor, bevor du Spielst:'),
                  SizedBox(height: 16),
                  Text('Was ist dein Geschlecht?'),
                  Center(
                    child: ResponsiveSelectionList(
                      horizontallMainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
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
                              Text('Männlich')
                            ],
                          ),
                        ),
                        Flexible(
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
                              Text('Weiblich')
                            ],
                          ),
                        ),
                        Flexible(
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
                              Text('Divers')
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
                      labelText: 'Wie willst du dich im Spiel nennen?',
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
                  Text('Was ist dein aktueller Beschäftigungsstatus?'),
                  ResponsiveSelectionList(
                    widthTolerance: 1100,
                    children: [
                      Flexible(
                        child: RadioListTile(
                          value: 1,
                          groupValue: selectedJob,
                          onChanged: (value) {
                            setState(() {
                              selectedJob = value!;
                            });
                          },
                          title: Text('Schüler:in'),
                        ),
                      ),
                      Flexible(
                        child: RadioListTile(
                          value: 2,
                          groupValue: selectedJob,
                          onChanged: (value) {
                            setState(() {
                              selectedJob = value!;
                            });
                          },
                          title: Text('Student:in'),
                        ),
                      ),
                      Flexible(
                        child: RadioListTile(
                          value: 3,
                          groupValue: selectedJob,
                          onChanged: (value) {
                            setState(() {
                              selectedJob = value!;
                            });
                          },
                          title: Text('Auszubildende:r'),
                        ),
                      ),
                      Flexible(
                        child: RadioListTile(
                          value: 4,
                          groupValue: selectedJob,
                          onChanged: (value) {
                            setState(() {
                              selectedJob = value!;
                            });
                          },
                          title: Text('Berufstätig'),
                        ),
                      ),
                      Flexible(
                        child: RadioListTile(
                          value: 5,
                          groupValue: selectedJob,
                          onChanged: (value) {
                            setState(() {
                              selectedJob = value!;
                            });
                          },
                          title: Text('Sonstige'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text('In welcher Branche bist du tätig?'),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: DropdownMenu(
                      enableSearch: false,
                      onSelected: (value) => selectedJobDefiniton = value!,
                      label: Text('Bitte auswählen'),
                      dropdownMenuEntries: <DropdownMenuEntry<int>>[
                        DropdownMenuEntry(
                            value: 1,
                            label: 'Handwerk, Technik und Produktion'),
                        DropdownMenuEntry(
                            value: 2,
                            label: 'Dienstleistungen und Handlungsberufe'),
                        DropdownMenuEntry(
                            value: 3,
                            label: 'Bildung, Kultur und kreative Berufe'),
                        DropdownMenuEntry(
                            value: 4, label: 'Gesundheit, Pflege und Soziales'),
                        DropdownMenuEntry(
                            value: 5,
                            label: 'Natur, Umwelt und Landwirtschaft'),
                        DropdownMenuEntry(
                            value: 6, label: 'IT, Technik und Digitalisierung'),
                        DropdownMenuEntry(
                            value: 7,
                            label: 'Wirtschaft, Verwaltung und Management'),
                        DropdownMenuEntry(
                            value: 8,
                            label: 'Sicherheit, Verkehr und Logistik'),
                        DropdownMenuEntry(value: 9, label: 'Sonstiges'),
                      ],
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
                      'Hast du das Spiel schon einmal gespielt? Wenn ja, wie oft?'),
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
      final job = getJob();
      final jobDefiniton = getJobDefiniton();

      final profile = ProfileModel(
        name: _nameController.text,
        age: int.parse(_ageController.text),
        salutation: getSalutation(),
        yearsOfExperience: int.parse(_yearsOfExperienceController.text),
        jobTitle: '$job - $jobDefiniton',
        gamePlayed: gamePlayed == 1 ? _gamePlayedController.text : 'Nein',
      );

      widget.gameBloc.add(
        SaveProfile(
          profile: profile,
          usePlayerTerm: widget.usePlayerTerm,
        ),
      );
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

  String getJob() {
    switch (selectedJob) {
      case 1:
        return 'Schüler:in';
      case 2:
        return 'Student:in';
      case 3:
        return 'Auszubildende:r';
      case 4:
        return 'Berufstätig:r';
      default:
        return 'Sonstige';
    }
  }

  String getJobDefiniton() {
    switch (selectedJobDefiniton) {
      case 1:
        return 'Handwerk / Technik / Produktion';
      case 2:
        return 'Dienstleistungen / Handlungsberufe';
      case 3:
        return 'Bildung / Kultur / kreative Berufe';
      case 4:
        return 'Gesundheit / Pflege / Soziales';
      case 5:
        return 'Natur / Umwelt / Landwirtschaft';
      case 6:
        return 'IT / Technik / Digitalisierung';
      case 7:
        return 'Wirtschaft / Verwaltung / Management';
      case 8:
        return 'Sicherheit / Verkehr / Logistik';
      default:
        return 'Sonstige';
    }
  }
}
