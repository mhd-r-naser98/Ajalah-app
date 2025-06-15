import 'dart:ui';

import 'package:flutter/material.dart';

@immutable
class AppRadius extends ThemeExtension<AppRadius> {
  final double sm;
  final double md;
  final double lg;

  const AppRadius({required this.sm, required this.md, required this.lg});

  @override
  AppRadius copyWith({double? sm, double? md, double? lg}) {
    return AppRadius(sm: sm ?? this.sm, md: md ?? this.md, lg: lg ?? this.lg);
  }

  @override
  AppRadius lerp(ThemeExtension<AppRadius>? other, double t) {
    if (other is! AppRadius) return this;
    return AppRadius(
      sm: lerpDouble(sm, other.sm, t)!,
      md: lerpDouble(md, other.md, t)!,
      lg: lerpDouble(lg, other.lg, t)!,
    );
  }

  static const radius = AppRadius(sm: 6.0, md: 8.0, lg: 12.0);
}
