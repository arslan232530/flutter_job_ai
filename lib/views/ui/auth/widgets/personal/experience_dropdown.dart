import 'package:flutter/material.dart';
import 'package:job_board/views/custom/custom_helper/height_spacer.dart';

class ExperienceDropdown extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;

  const ExperienceDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Experience (Years)',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
        const HeightSpacer(size: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: value,
              isExpanded: true,
              items: List.generate(
                6,
                (index) =>
                    DropdownMenuItem(value: index, child: Text('$index years')),
              ),
              onChanged: (val) {
                if (val != null) onChanged(val);
              },
            ),
          ),
        ),
      ],
    );
  }
}
