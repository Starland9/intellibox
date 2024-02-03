// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intellibox/models/tool/tool.dart';
import 'package:intellibox/modules/global/global_tool_page.dart';
import 'package:intellibox/utils/logic.dart';
import 'package:intellibox/utils/store.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IntelliBox"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(_buildHeadText),
            Divider(
              color: Colors.grey.shade800,
            ),
            Expanded(
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                children: AppStore.tools.map((e) => ToolCard(tool: e)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String get _buildHeadText =>
      "Des tonnes d'outils afin d'ameliorer ta productivité";
}

class ToolCard extends StatelessWidget {
  const ToolCard({
    super.key,
    required this.tool,
  });

  final Tool tool;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (tool.page == null) {
          return;
        }
        Nav.push(context, GlobalToolPage(tool: tool));
      },
      child: GFCard(
        elevation: 0,
        padding: EdgeInsets.all(2),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              tool.image,
              width: 50,
              height: 50,
            ),
            SizedBox(height: 5),
            Text(
              tool.title,
              textAlign: TextAlign.center,
              style: GoogleFonts.aBeeZee(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
