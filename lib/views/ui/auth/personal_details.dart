import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:job_board/controllers/auth/login/login_provider.dart';
import 'package:job_board/controllers/auth/personal/personal_details_provider.dart';
import 'package:job_board/controllers/image/profile_image_provider.dart';
import 'package:job_board/helper/ui_helper.dart';
import 'package:job_board/models/request/auth/profile_update_model.dart';
import 'package:job_board/views/custom/custom_helper/height_spacer.dart';
import 'package:job_board/views/ui/auth/widgets/personal/experience_dropdown.dart';
import 'package:job_board/views/ui/auth/widgets/personal/profile_fields.dart';
import 'package:job_board/views/ui/auth/widgets/personal/profile_image.dart';
import 'package:job_board/views/ui/auth/widgets/skills/personal_skills.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalDetails extends ConsumerStatefulWidget {
  const PersonalDetails({super.key});

  @override
  ConsumerState<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends ConsumerState<PersonalDetails> {
  late final TextEditingController _locationController;
  late final TextEditingController _phoneController;
  late final TextEditingController _jobTitleController;
  final TextEditingController _skillController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final state = ref.read(personalDetailsProvider);
    _locationController = TextEditingController(text: state.location);
    _phoneController = TextEditingController(text: state.phone);
    _jobTitleController = TextEditingController(text: state.jobTitle);
  }

  @override
  void dispose() {
    _locationController.dispose();
    _phoneController.dispose();
    _jobTitleController.dispose();
    _skillController.dispose();
    super.dispose();
  }

  void _showAddSkillDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Add Skill',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        content: TextField(
          controller: _skillController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Enter skill name',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _skillController.clear();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final skill = _skillController.text.trim();
              if (skill.isNotEmpty) {
                ref.read(personalDetailsProvider.notifier).addSkill(skill);
                _skillController.clear();
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Future<void> _saveProfile() async {
    final profileImageState = ref.read(profileImageProvider);
    final personalNotifier = ref.read(personalDetailsProvider);
    final File? imageFile = profileImageState.localPath != null
        ? File(profileImageState.localPath!)
        : null;

    if (imageFile == null) {
      UIHelper.showErrorSnackBar(context, 'Choose Image');
      return;
    }

    final updateModel = ProfileUpdateReq(
      location: _locationController.text.trim(),
      phone: _phoneController.text.trim(),
      skills: personalNotifier.skills,
      jobTitle: personalNotifier.jobTitle,
      experience: personalNotifier.experience,
    );

    final loginNotifier = ref.read(loginProvider.notifier);

    final result = await loginNotifier.updateProfile(
      updateModel,
      imageFile: imageFile,
    );

    if (!mounted) return;
    if (result) {
      UIHelper.showSuccessSnackBar(context, 'Profile Updated');
      final SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setStringList('userskills', personalNotifier.skills);
      context.push('/profile');
    } else {
      UIHelper.showErrorSnackBar(context, 'Something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(personalDetailsProvider);
    final notifier = ref.read(personalDetailsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Details'),
        actions: [
          TextButton(onPressed: _saveProfile, child: const Text('Save')),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const ProfilePictureSection(),
            const HeightSpacer(size: 32),
            PersonalInfoSection(
              location: state.location,
              phone: state.phone,
              jobTitle: state.jobTitle,
              onJobTitleChanged: (value) {
                _jobTitleController.text = value;
                notifier.updateJobTitle(value);
              },
              onLocationChanged: (value) {
                _locationController.text = value;
                notifier.updateLocation(value);
              },
              onPhoneChanged: (value) {
                _phoneController.text = value;
                notifier.updatePhone(value);
              },
            ),
            ExperienceDropdown(
              value: state.experience,
              onChanged: (value) {
                notifier.updateExperience(value);
              },
            ),

            const HeightSpacer(size: 24),
            SkillsSection(
              skillController: _skillController,
              allSkills: state.skills,
              onAddSkill: _showAddSkillDialog,
            ),
          ],
        ),
      ),
    );
  }
}
