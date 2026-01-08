import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_board/constants/app_constant.dart';
import 'package:job_board/views/custom/custom_helper/app_style.dart';

class CustomMessageWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged; // Called when text changes
  final Function(String)? onSubmitted; // Called when user presses enter/send
  final Function()? onEditingComplete; // Called when user finishes editing
  final Function(PointerDownEvent)?
  onTapOutside; // Called when tapping outside the text field
  final VoidCallback onSendPressed; // Called when send icon is pressed
  final String hintText; // Placeholder text
  final bool showSendIcon; // Whether to show send icon

  const CustomMessageWidget({
    super.key,
    required this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
    this.onTapOutside,
    required this.onSendPressed,
    this.hintText = 'Type your message...',
    this.showSendIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: Offset(0, 4),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(kLight.value).withOpacity(0.9), Color(kLight.value)],
        ),
      ),
      child: TextField(
        controller: controller, // Controls the text input
        cursorColor: Color(0xFF6366F1),
        keyboardType: TextInputType.multiline,
        maxLines: null, // Allows multiple lines
        style: appstyle(16, Color(kDark.value), FontWeight.w500),

        // Event handlers:
        onChanged: onChanged, // When user types (track text changes)
        onSubmitted: onSubmitted, // When user presses enter/keyboard done
        onEditingComplete:
            onEditingComplete, // When editing finishes (keyboard hides)
        onTapOutside: onTapOutside, // When user taps outside text field

        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Color(kDarkGrey.value).withOpacity(0.6),
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            vertical: 12.h,
            horizontal: 16.h,
          ),

          suffixIcon: showSendIcon
              ? Container(
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF6366F1).withOpacity(0.3),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: onSendPressed, // When user taps send icon
                    icon: const Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
