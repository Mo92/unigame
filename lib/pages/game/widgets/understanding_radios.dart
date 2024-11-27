import 'package:flutter/material.dart';

class RadioGroupWidget extends StatelessWidget {
  final int groupValue;
  final ValueChanged<int?> onChanged;
  final List<String> options;

  const RadioGroupWidget({
    super.key,
    required this.groupValue,
    required this.onChanged,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: options.asMap().entries.map((entry) {
        int index = entry.key;
        String label = entry.value;
        return Expanded(
          child: Row(
            children: [
              Radio<int>(
                value: index,
                groupValue: groupValue,
                onChanged: onChanged,
              ),
              Expanded(
                child: Text(label),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
