import 'package:flutter/material.dart';

import 'app_shared_colors.dart' show SharedColors;
import 'extensions/app_colors.dart' show AppColors;
import 'extensions/app_radius.dart';
import 'extensions/app_text_styles.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Cairo',
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: SharedColors.primary.main),
    scaffoldBackgroundColor: AppColors.light.background,
    extensions: [AppColors.light, AppTextStyles.light, AppRadius.radius],
    primaryColor: SharedColors.primary.main,
    primaryColorLight: SharedColors.primary.main,
    cardColor: AppColors.light.box,

    dividerColor: SharedColors.grey[300],
    shadowColor: SharedColors.grey[300],
    canvasColor: AppColors.light.box,

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.light.background,
      elevation: 0,
      foregroundColor: AppColors.light.background,
      iconTheme: IconThemeData(color: SharedColors.primary.main),
    ),

    colorScheme: ColorScheme.light(
      primary: SharedColors.primary.main,
      secondary: SharedColors.secondary.main,
      surface: AppColors.light.box,
      error: SharedColors.error.main,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.light.background,
      titleTextStyle: TextStyle(color: Colors.amber),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: 'Cairo',
    brightness: Brightness.dark,
    iconTheme: IconThemeData(color: SharedColors.primary.main),
    canvasColor: AppColors.dark.box,
    scaffoldBackgroundColor: AppColors.dark.background,
    extensions: [AppColors.dark, AppTextStyles.dark, AppRadius.radius],
    primaryColor: SharedColors.primary.main,
    cardColor: AppColors.dark.box,
    hoverColor: SharedColors.primary.main.withAlpha(25),
    highlightColor: SharedColors.primary.main.withAlpha(51),
    dividerColor: SharedColors.grey[700],
    shadowColor: SharedColors.grey[900],
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.dark.background,
      elevation: 0,
      foregroundColor: SharedColors.secondary.contrast,
      iconTheme: IconThemeData(color: SharedColors.primary.main),
    ),

    colorScheme: ColorScheme.dark(
      primary: SharedColors.primary.main,
      secondary: SharedColors.secondary.main,
      surface: AppColors.dark.background,
      error: SharedColors.error.main,
    ),
    dialogTheme: DialogThemeData(backgroundColor: AppColors.dark.background),
  );
}
