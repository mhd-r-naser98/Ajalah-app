import 'package:flutter/material.dart';
import 'groups/color_group.dart';

abstract class SharedColors {
  // Primary Colors
  static const Map<int, Color> grey = {
    0: Color(0xFFFFFFFF),
    100: Color(0xFFF9FAFB),
    200: Color(0xFFF2F2F7),
    250: Color(0xFFE5E5EA),
    300: Color(0xFFDFE3E8),
    400: Color(0xFFC4CDD5),
    500: Color(0xFF919EAB),
    600: Color(0xFF8E8E93),
    700: Color(0xFFAEAEB2),
    800: Color(0xFF212B36),
    900: Color(0xFF161C24),
  };
  static const ColorGroup primary = ColorGroup(
    main: Color(0xFF02C0AA),
    lighter: Color(0xFFA0EDE3),
    light: Color(0xFF56DBC0),
    dark: Color(0xFF028374),
    darker: Color(0xFF006656),
    contrast: Color(0xFF141b23),
  );

  static const ColorGroup secondary = ColorGroup(
    main: Color(0xFF2A3950),
    lighter: Color(0xFF6C8AC9),
    light: Color(0xFF4A6CCC),
    dark: Color(0xFF1A293D),
    darker: Color(0xFF0F192A),
    contrast: Colors.white,
  );

  static const ColorGroup success = ColorGroup(
    main: Color(0xFF22C55E),
    lighter: Color(0xFFD3FCD2),
    light: Color(0xFF77ED8B),
    dark: Color(0xFF118D57),
    darker: Color(0xFF065E49),
    contrast: Colors.white,
  );

  static const ColorGroup info = ColorGroup(
    main: Color(0xFF00B8D9),
    lighter: Color(0xFFCAFDF5),
    light: Color(0xFF61F3F3),
    dark: Color(0xFF006C9C),
    darker: Color(0xFF003768),
    contrast: Colors.white,
  );

  static const ColorGroup warning = ColorGroup(
    main: Color(0xFFFFAB00),
    lighter: Color(0xFFFFF5CC),
    light: Color(0xFFFFD666),
    dark: Color(0xFFB76E00),
    darker: Color(0xFF7A4100),
    contrast: Colors.black,
  );

  static const ColorGroup error = ColorGroup(
    main: Color(0xFFFF5630),
    lighter: Color(0xFFFFE9D5),
    light: Color(0xFFFFAC82),
    dark: Color(0xFFFA2111),
    darker: Color(0xFF7A0916),
    contrast: Colors.white,
  );
}
