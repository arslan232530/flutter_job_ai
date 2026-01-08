// import 'package:flutter/material.dart';
// import 'package:job_board/views/custom/custom_helper/app_style.dart';
// import 'package:job_board/views/custom/custom_helper/height_spacer.dart';
// import 'package:job_board/views/custom/custom_text/reusable_text.dart';

// class SkillsSection extends StatefulWidget {
//   const SkillsSection({
//     super.key,
//     required this.skillController,
//     required this.allSkills,
//   });
//   final TextEditingController skillController;
//   final List<String> allSkills;

//   @override
//   State<SkillsSection> createState() => _SkillsSectionState();
// }

// class _SkillsSectionState extends State<SkillsSection> {
//   final List<String> _skills = ['Flutter', 'UI Design', 'Dart'];
//   void _addSkill() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: ReusableText(
//           text: 'Add Skill',
//           style: appstyle(20, Colors.black, FontWeight.w500),
//         ),
//         content: TextField(
//           controller: widget.skillController,
//           autofocus: true,
//           decoration: const InputDecoration(
//             hintText: 'Enter skill name',
//             border: OutlineInputBorder(),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               widget.skillController.clear();
//             },
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               if (widget.skillController.text.trim().isNotEmpty) {
//                 setState(() {
//                   _skills.add(widget.skillController.text.trim());
//                 });

//                 widget.skillController.clear();
//                 Navigator.pop(context);
//               }
//             },
//             child: const Text('Add'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _removeSkill(int index) {
//     setState(() {
//       _skills.removeAt(index);
//     });
//   }

//   @override
//   void dispose() {
//     widget.skillController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Section Title
//         ReusableText(
//           text: 'Add Skills',
//           style: appstyle(18, theme.colorScheme.primary, FontWeight.w500),
//         ),
//         const HeightSpacer(size: 16),

//         // Skills Chips
//         Wrap(
//           spacing: 12,
//           runSpacing: 12,
//           children: [
//             ..._skills.asMap().entries.map((entry) {
//               final index = entry.key;
//               final skill = entry.value;
//               return SkillChip(
//                 skill: skill,
//                 onDelete: () => _removeSkill(index),
//               );
//             }),

//             // Add Skill Button
//             AddSkillButton(onPressed: _addSkill),
//           ],
//         ),

//         // Instruction Text
//         Padding(
//           padding: const EdgeInsets.only(top: 16),
//           child: Text(
//             'Tap the plus icon to add more skills to your profile.',
//             style: appstyle(
//               16,
//               theme.colorScheme.onSurface.withValues(alpha: 0.8),
//               FontWeight.w400,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:job_board/views/custom/custom_text/reusable_text.dart';
import 'package:job_board/views/ui/auth/widgets/skills/widgets/add_skill_button.dart';
import 'package:job_board/views/ui/auth/widgets/skills/widgets/remove_skill_chip.dart';

class SkillsSection extends StatelessWidget {
  final TextEditingController skillController;
  final List<String> allSkills;
  final VoidCallback onAddSkill;

  const SkillsSection({
    super.key,
    required this.skillController,
    required this.allSkills,
    required this.onAddSkill,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Flatten comma-separated skills into individual skills
    final skills = allSkills
        .map((s) => s.split(','))
        .expand((e) => e)
        .map((s) => s.trim())
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        ReusableText(
          text: 'Add Skills',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 16),
        // Skills Chips
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ...skills.map((skill) {
              return SkillChip(
                skill: skill,
              );
            }),
            AddSkillButton(onPressed: onAddSkill),
          ],
        ),
        const SizedBox(height: 16),
        const Text('Tap the plus icon to add more skills to your profile.'),
      ],
    );
  }
}
