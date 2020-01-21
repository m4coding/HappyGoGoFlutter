import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {

  static const int primaryIntValue = 0xFFE91E63;

  static const MaterialColor primarySwatch = const MaterialColor(
    primaryIntValue,
    const <int, Color>{
      50: const Color(primaryIntValue),
      100: const Color(primaryIntValue),
      200: const Color(primaryIntValue),
      300: const Color(primaryIntValue),
      400: const Color(primaryIntValue),
      500: const Color(primaryIntValue),
      600: const Color(primaryIntValue),
      700: const Color(primaryIntValue),
      800: const Color(primaryIntValue),
      900: const Color(primaryIntValue),
    },
  );

  static const Color primary = Color(0xFFE91E63);
  static const Color accent = Color(0xFFFF5722);
  static const Color primary_text = Color(0xFF212121);
  static const Color secondary_text = Color(0xFF757575);
  static const Color icons = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFBDBDBD);

  static const Color white = Color(0xFFFFFFFF);
  static const Color transparent = Color(0x00000000);
}