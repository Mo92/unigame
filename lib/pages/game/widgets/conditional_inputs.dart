import 'package:flutter/material.dart';

class ConditionalInputWidget extends StatelessWidget {
  final int selectedValue; // 0 = Nein, 1 = Ja
  final ValueChanged<int?> onValueChanged;
  final TextEditingController textController;
  final String label; // Optionales Label für das Textfeld

  const ConditionalInputWidget({
    super.key,
    required this.selectedValue,
    required this.onValueChanged,
    required this.textController,
    this.label = "Bitte eingeben:",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Radio<int>(
                    value: 0,
                    groupValue: selectedValue,
                    onChanged: onValueChanged,
                  ),
                  const Text('Nein'),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Radio<int>(
                    value: 1,
                    groupValue: selectedValue,
                    onChanged: onValueChanged,
                  ),
                  const Text('Ja'),
                ],
              ),
            ),
          ],
        ),
        if (selectedValue == 1)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: textController,
                decoration: InputDecoration(
                  labelText: label,
                  errorText: textController.text.isEmpty
                      ? 'Dieses Feld darf nicht leer sein'
                      : null,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
