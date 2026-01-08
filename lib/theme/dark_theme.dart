import 'package:flutter/material.dart';
import 'package:job_board/theme/app_colors.dart';

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.darkBackground,

  colorScheme: const ColorScheme.dark(
    primary: AppColors.primary,
    onPrimary: AppColors.darkTextOnPrimary,
    primaryContainer: AppColors.primaryDark,
    onPrimaryContainer: AppColors.darkTextOnPrimary,

    secondary: AppColors.secondaryDark,
    onSecondary: AppColors.darkTextOnSecondary,
    secondaryContainer: AppColors.secondaryDark,
    onSecondaryContainer: AppColors.darkTextOnSecondary,

    surface: AppColors.darkSurface,
    onSurface: AppColors.darkTextPrimary,
    surfaceContainerHighest: AppColors.darkBorder,
    onSurfaceVariant: AppColors.darkTextSecondary,

    error: AppColors.error,
    onError: Colors.white,
    errorContainer: AppColors.error,
    onErrorContainer: Colors.white,
  ),
);

  // appBarTheme: const AppBarTheme(
  //   backgroundColor: AppColors.darkSurface,
  //   foregroundColor: AppColors.darkTextPrimary,
  //   elevation: 0,
  // ),

  // cardTheme: CardThemeData(
  //   color: AppColors.darkSurface,
  //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  // ),

  // inputDecorationTheme: InputDecorationTheme(
  //   filled: true,
  //   fillColor: AppColors.darkSurface,
  //   border: OutlineInputBorder(
  //     borderRadius: BorderRadius.circular(10),
  //     borderSide: const BorderSide(color: AppColors.darkBorder),
  //   ),
  //   enabledBorder: OutlineInputBorder(
  //     borderRadius: BorderRadius.circular(10),
  //     borderSide: const BorderSide(color: AppColors.darkBorder),
  //   ),
  // ),

  // elevatedButtonTheme: ElevatedButtonThemeData(
  //   style: ElevatedButton.styleFrom(
  //     backgroundColor: AppColors.primary,
  //     foregroundColor: AppColors.darkTextOnPrimary,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //   ),
  // ),

  // dividerTheme: const DividerThemeData(color: AppColors.darkBorder),

  // iconTheme: const IconThemeData(color: AppColors.darkIcon),
//);
