import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_board/views/custom/custom_helper/app_style.dart';
import 'package:job_board/views/custom/custom_helper/height_spacer.dart';

class PersonalProfileInputField extends StatefulWidget {
  final String label;
  final String value;
  final ValueChanged<String> onChanged;
  final IconData icon;
  final TextInputType keyboardType;

  const PersonalProfileInputField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    required this.icon,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<PersonalProfileInputField> createState() =>
      _PersonalProfileInputFieldState();
}

class _PersonalProfileInputFieldState extends State<PersonalProfileInputField> {
  bool _isFocused = false;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);

    // Keep controller in sync if value changes externally
    _controller.addListener(() {
      if (_controller.text != widget.value) {
        widget.onChanged(_controller.text);
      }
    });
  }

  @override
  void didUpdateWidget(covariant PersonalProfileInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value && _controller.text != widget.value) {
      _controller.text = widget.value;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: appstyle(
            16,
            theme.colorScheme.onSurface.withValues(alpha: 0.5),
            FontWeight.w500,
          ),
        ),
        const HeightSpacer(size: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: _isFocused
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurface.withValues(alpha: 0.3),
              width: _isFocused ? 1.5 : 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Focus(
            onFocusChange: (hasFocus) {
              setState(() {
                _isFocused = hasFocus;
              });
            },
            child: TextField(
              controller: _controller,
              keyboardType: widget.keyboardType,
              style: appstyle(16, theme.colorScheme.onSurface, FontWeight.w500),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                prefixIcon: Icon(
                  widget.icon,
                  color: _isFocused
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  size: 24.sp,
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                suffixIcon: _controller.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.5,
                          ),
                          size: 20.sp,
                        ),
                        onPressed: () {
                          _controller.clear();
                        },
                      )
                    : Icon(
                        Icons.edit_outlined,
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.5,
                        ),
                        size: 20.sp,
                      ),
              ),
              cursorColor: theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
