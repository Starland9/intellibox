// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intellibox/modules/apis/ninja.dart';
import 'package:intellibox/modules/devinette/model.dart';
import 'package:intellibox/utils/theme.dart';
import 'package:translator/translator.dart';

class DevinettePage extends StatefulWidget {
  const DevinettePage({super.key});

  @override
  State<DevinettePage> createState() => _DevinettePageState();
}

Devinette? devinette;

class _DevinettePageState extends State<DevinettePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          if (devinette != null)
            Expanded(
                child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  devinette!.title.toUpperCase(),
                  style: GoogleFonts.aBeeZee(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  devinette!.question,
                  style: GoogleFonts.aBeeZee(
                    fontSize: 18,
                    color: Colors.amber,
                  ),
                ),
                Divider(),
                Text(
                  devinette!.answer,
                  style: GoogleFonts.aBeeZee(
                    color: Colors.green,
                  ),
                ),
              ],
            )),
          GFButton(
            onPressed: () async {
              Devinette? d = await Ninja.getDevinette(1);
              if (d != null) {
                devinette = Devinette(await d.title.translate(to: "fr"), question, answer)
              }
            },
            text: "Générer",
            color: Scolors.primary,
            splashColor: Scolors.bgColor.withOpacity(0.5),
            textStyle: GoogleFonts.aBeeZee(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Scolors.bgColor,
            ),
            fullWidthButton: true,
            size: 45,
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
