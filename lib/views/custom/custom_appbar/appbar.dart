import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_board/views/custom/custom_helper/app_style.dart';
import 'package:job_board/views/custom/custom_text/reusable_text.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, this.text, required this.child, this.actions});

  final String? text;
  final Widget child;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: theme.colorScheme.surface,
      iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
      leadingWidth: 70.w,
      leading: child,
      actions: actions,
      centerTitle: true,
      title: ReusableText(
        text: text ?? '',
        style: appstyle(18, theme.colorScheme.onSurface, FontWeight.normal),
      ),
    );
  }
}
