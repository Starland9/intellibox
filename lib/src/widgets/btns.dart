import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/theme.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.text,
    this.icon,
    this.onPressed,
  });

  final String text;
  final Widget? icon;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GFButton(
      icon: icon,
      onPressed: onPressed,
      text: text,
      color: Scolors.primary,
      splashColor: Scolors.bgColor.withValues(alpha: 0.5),
      textStyle: GoogleFonts.aBeeZee(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Scolors.bgColor,
      ),
      fullWidthButton: true,
      size: 45,
    );
  }
}
