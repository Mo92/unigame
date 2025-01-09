import 'package:flutter/material.dart';
import 'package:shadow_deals/pages/game/widgets/responsive_selection_list.dart';

class RadioGroupWidget extends StatelessWidget {
  final int groupValue;
  final ValueChanged<int?> onChanged;
  final List<String> options;
  final int widthTolerance;

  const RadioGroupWidget({
    super.key,
    required this.groupValue,
    required this.onChanged,
    required this.options,
    this.widthTolerance = 550,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveSelectionList(
      widthTolerance: widthTolerance,
      children: options.asMap().entries.map((entry) {
        int index = entry.key;
        String label = entry.value;
        return Flexible(
          child: Row(
            children: [
              Radio<int>(
                value: index,
                groupValue: groupValue,
                onChanged: onChanged,
              ),
              Text(label),
            ],
          ),
        );
      }).toList(),
    );
  }
}
