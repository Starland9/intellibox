// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intellibox/src/models/tool/tool.dart';

class GlobalToolPage extends StatelessWidget {
  const GlobalToolPage({super.key, required this.tool});

  final Tool tool;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: ImageIcon(Image.asset(tool.image).image),
        title: Text(tool.title),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.help_outline,
            ),
          ),
        ],
      ),
      body: tool.page,
    );
  }
}
