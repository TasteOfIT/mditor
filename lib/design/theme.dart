import 'package:flutter/material.dart';

class MditorTheme {
  static ThemeData get light {
    return ThemeData.from(colorScheme: const ColorScheme.light(), useMaterial3: true);
  }

  static ThemeData get dark {
    return ThemeData.from(colorScheme: const ColorScheme.dark(), useMaterial3: true);
  }
}
