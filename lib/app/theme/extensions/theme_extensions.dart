import 'package:flutter/material.dart';
import '../../../app/localization/app_localizations.dart';
import 'app_colors.dart';
import 'app_radius.dart';
import 'app_text_styles.dart';

extension ThemeContextExtension on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
  AppTextStyles get textStyles => Theme.of(this).extension<AppTextStyles>()!;
  AppRadius get radius => Theme.of(this).extension<AppRadius>()!;
  String t(String key) => AppLocalizations.of(this)?.ts(key) ?? key;
}
