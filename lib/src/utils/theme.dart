import 'package:flutter/material.dart';

class Scolors {
  static Color primary = Colors.white70;
  static Color bgColor = const Color.fromARGB(255, 27, 32, 36);
  static Color fieldFillColor = const Color.fromARGB(255, 29, 28, 28);
}

class STheme {
  static ThemeData normal = ThemeData(
    colorSchemeSeed: Scolors.primary,
    useMaterial3: true,
    // scaffoldBackgroundColor: Scolors.bgColor,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(borderSide: BorderSide.none),
      contentPadding: EdgeInsets.all(8),
      filled: true,
      fillColor: Color.fromARGB(255, 44, 43, 43),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    ),
  );
}
