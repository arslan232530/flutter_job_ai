import 'package:flutter/material.dart';
import 'package:job_board/theme/app_colors.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.lightBackground,

  colorScheme: const ColorScheme.light(
    primary: AppColors.primary,
    onPrimary: AppColors.lightTextOnPrimary,
    primaryContainer: AppColors.primaryContainer,
    onPrimaryContainer: AppColors.onPrimaryContainer,

    secondary: AppColors.secondaryLight,
    onSecondary: AppColors.lightTextOnSecondary,
    secondaryContainer: AppColors.secondaryContainer,
    onSecondaryContainer: AppColors.onSecondaryContainer,

    surface: AppColors.lightSurface,
    onSurface: AppColors.lightTextPrimary,
    surfaceContainerHighest: AppColors.lightBorder,
    onSurfaceVariant: AppColors.lightTextSecondary,

    error: AppColors.error,
    onError: Colors.white,
    errorContainer: AppColors.errorContainer,
    onErrorContainer: AppColors.onErrorContainer,
  ),
);

  // appBarTheme: const AppBarTheme(
  //   backgroundColor: AppColors.lightSurface,
  //   foregroundColor: AppColors.lightTextPrimary,
  //   elevation: 0,
  // ),

  // cardTheme: CardThemeData(
  //   color: AppColors.lightSurface,
  //   shape: RoundedRectangleBorder(
  //     borderRadius: BorderRadius.circular(12),
  //   ),
  // ),

  // inputDecorationTheme: InputDecorationTheme(
  //   filled: true,
  //   fillColor: AppColors.lightSurface,
  //   border: OutlineInputBorder(
  //     borderRadius: BorderRadius.circular(10),
  //     borderSide: const BorderSide(color: AppColors.lightBorder),
  //   ),
  //   enabledBorder: OutlineInputBorder(
  //     borderRadius: BorderRadius.circular(10),
  //     borderSide: const BorderSide(color: AppColors.lightBorder),
  //   ),
  // ),

  // elevatedButtonTheme: ElevatedButtonThemeData(
  //   style: ElevatedButton.styleFrom(
  //     backgroundColor: AppColors.primary,
  //     foregroundColor: AppColors.lightTextOnPrimary,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(10),
  //     ),
  //   ),
  // ),

  // dividerTheme: const DividerThemeData(
  //   color: AppColors.lightBorder,
  // ),

  // iconTheme: const IconThemeData(
  //   color: AppColors.lightIcon,
  // ),
//);