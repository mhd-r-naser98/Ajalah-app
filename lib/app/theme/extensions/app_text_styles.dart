import 'package:flutter/material.dart';
import '../groups/text_style_group.dart';

@immutable
class AppTextStyles extends ThemeExtension<AppTextStyles> {
  final TextStyleGroup styles;

  const AppTextStyles({required this.styles});

  @override
  AppTextStyles copyWith({TextStyleGroup? styles}) =>
      AppTextStyles(styles: styles ?? this.styles);

  @override
  AppTextStyles lerp(ThemeExtension<AppTextStyles>? other, double t) {
    if (other is! AppTextStyles) return this;
    return AppTextStyles(
      styles: TextStyleGroup(
        displayLarge: TextStyle.lerp(
          styles.displayLarge,
          other.styles.displayLarge,
          t,
        )!,
        displayMedium: TextStyle.lerp(
          styles.displayMedium,
          other.styles.displayMedium,
          t,
        )!,
        displaySmall: TextStyle.lerp(
          styles.displaySmall,
          other.styles.displaySmall,
          t,
        )!,
        headlineLarge: TextStyle.lerp(
          styles.headlineLarge,
          other.styles.headlineLarge,
          t,
        )!,
        headlineMedium: TextStyle.lerp(
          styles.headlineMedium,
          other.styles.headlineMedium,
          t,
        )!,
        headlineSmall: TextStyle.lerp(
          styles.headlineSmall,
          other.styles.headlineSmall,
          t,
        )!,
        titleLarge: TextStyle.lerp(
          styles.titleLarge,
          other.styles.titleLarge,
          t,
        )!,
        titleMedium: TextStyle.lerp(
          styles.titleMedium,
          other.styles.titleMedium,
          t,
        )!,
        titleSmall: TextStyle.lerp(
          styles.titleSmall,
          other.styles.titleSmall,
          t,
        )!,
        bodyLarge: TextStyle.lerp(styles.bodyLarge, other.styles.bodyLarge, t)!,
        bodyMedium: TextStyle.lerp(
          styles.bodyMedium,
          other.styles.bodyMedium,
          t,
        )!,
        bodySmall: TextStyle.lerp(styles.bodySmall, other.styles.bodySmall, t)!,
        labelLarge: TextStyle.lerp(
          styles.labelLarge,
          other.styles.labelLarge,
          t,
        )!,
        labelMedium: TextStyle.lerp(
          styles.labelMedium,
          other.styles.labelMedium,
          t,
        )!,
        labelSmall: TextStyle.lerp(
          styles.labelSmall,
          other.styles.labelSmall,
          t,
        )!,
        linkLarge: TextStyle.lerp(styles.linkLarge, other.styles.linkLarge, t)!,
        linkMedium: TextStyle.lerp(
          styles.linkMedium,
          other.styles.linkMedium,
          t,
        )!,
        linkSmall: TextStyle.lerp(styles.linkSmall, other.styles.linkSmall, t)!,
      ),
    );
  }

  static const _lineHeight = 1.20;
  static const _fontFamily = 'Cairo';
  static const _defaultColor = Color(0xFF2A3950);
  static const _accentColor = Color(0xFF02C0AA);
  static const _labelGrey = Color(0xFF8E8E93);

  static TextStyle _style({
    required double fontSize,
    FontWeight? weight,
    Color? color,
  }) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: fontSize,
    fontWeight: weight,
    height: _lineHeight,
    color: color ?? _defaultColor,
  );

  static final light = AppTextStyles(
    styles: TextStyleGroup(
      displayLarge: _style(fontSize: 57),
      displayMedium: _style(fontSize: 40),
      displaySmall: _style(fontSize: 36, weight: FontWeight.bold),
      headlineLarge: _style(fontSize: 32, weight: FontWeight.bold),
      headlineMedium: _style(fontSize: 30, weight: FontWeight.w700),
      headlineSmall: _style(fontSize: 28, weight: FontWeight.w700),
      titleLarge: _style(fontSize: 24),
      titleMedium: _style(fontSize: 20, weight: FontWeight.w700),
      titleSmall: _style(fontSize: 18, weight: FontWeight.w500),
      bodyLarge: _style(fontSize: 16),
      bodyMedium: _style(fontSize: 14),
      bodySmall: _style(fontSize: 12),
      labelLarge: _style(fontSize: 16, color: _labelGrey),
      labelMedium: _style(fontSize: 14),
      labelSmall: _style(fontSize: 12, weight: FontWeight.w500),
      linkLarge: _style(fontSize: 16, color: _accentColor),
      linkMedium: _style(fontSize: 14, color: _accentColor),
      linkSmall: _style(fontSize: 12, color: _accentColor),
    ),
  );

  static final dark = AppTextStyles(
    styles: TextStyleGroup(
      displayLarge: _style(fontSize: 57, color: Colors.white),
      displayMedium: _style(fontSize: 40, color: Colors.white),
      displaySmall: _style(
        fontSize: 36,
        weight: FontWeight.bold,
        color: Colors.white,
      ),
      headlineLarge: _style(
        fontSize: 32,
        weight: FontWeight.bold,
        color: Colors.white,
      ),
      headlineMedium: _style(
        fontSize: 30,
        weight: FontWeight.w700,
        color: Colors.white,
      ),
      headlineSmall: _style(
        fontSize: 28,
        weight: FontWeight.w700,
        color: Colors.white,
      ),
      titleLarge: _style(
        fontSize: 24,
        weight: FontWeight.bold,
        color: Colors.white,
      ),
      titleMedium: _style(
        fontSize: 20,
        weight: FontWeight.w700,
        color: Colors.white,
      ),
      titleSmall: _style(
        fontSize: 18,
        weight: FontWeight.w500,
        color: Colors.white,
      ),
      bodyLarge: _style(fontSize: 16, color: Colors.white),
      bodyMedium: _style(fontSize: 14, color: Colors.white),
      bodySmall: _style(fontSize: 12, color: Colors.white),
      labelLarge: _style(fontSize: 16, color: _labelGrey),
      labelMedium: _style(fontSize: 14, color: Colors.white),
      labelSmall: _style(fontSize: 12, color: Colors.white),
      linkLarge: _style(fontSize: 16, color: _accentColor),
      linkMedium: _style(fontSize: 14, color: _accentColor),
      linkSmall: _style(fontSize: 12, color: _accentColor),
    ),
  );

  get titleLarge => null;

  get displayLarge => null;
}
