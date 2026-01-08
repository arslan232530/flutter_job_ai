import 'package:flutter/material.dart';
import 'package:job_board/views/custom/custom_helper/height_spacer.dart';
import 'package:job_board/views/ui/auth/widgets/personal/input_field_profile.dart';

class PersonalInfoSection extends StatelessWidget {
  final String location;
  final String phone;
  final String jobTitle;
  final ValueChanged<String> onLocationChanged;
  final ValueChanged<String> onPhoneChanged;
  final ValueChanged<String> onJobTitleChanged;

  const PersonalInfoSection({
    super.key,
    required this.location,
    required this.phone,
    required this.jobTitle,
    required this.onLocationChanged,
    required this.onPhoneChanged,
    required this.onJobTitleChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PersonalProfileInputField(
          label: 'Location',
          value: location,
          onChanged: onLocationChanged,
          icon: Icons.location_on_outlined,
        ),
        const HeightSpacer(size: 20),
        PersonalProfileInputField(
          label: 'Job Title',
          value: jobTitle,
          onChanged: onJobTitleChanged,
          icon: Icons.work_outline,
        ),
        const HeightSpacer(size: 20),
        PersonalProfileInputField(
          label: 'Phone',
          value: phone,
          onChanged: onPhoneChanged,
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
        ),
        const HeightSpacer(size: 20),
      ],
    );
  }
}
