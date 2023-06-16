import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Scolors {
  static Color primary = Colors.white70;
  static Color bgColor = const Color.fromARGB(255, 23, 25, 27);
}

class STheme {
  static ThemeData normal = ThemeData(
    textTheme: GoogleFonts.aBeeZeeTextTheme().copyWith(
        bodyMedium: TextStyle(
      color: Scolors.primary,
    )),
    colorSchemeSeed: Scolors.primary,
    useMaterial3: true,
    scaffoldBackgroundColor: Scolors.bgColor,
    appBarTheme: AppBarTheme(
      color: Scolors.bgColor,
      foregroundColor: Scolors.primary,
      centerTitle: true,
      titleTextStyle: GoogleFonts.aBeeZee(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
