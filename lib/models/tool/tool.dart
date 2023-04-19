import 'package:flutter/material.dart';

class Tool {
  final String title;
  final String description;
  final String category;
  final String image;
  final Widget? page;

  Tool(
    this.title,
    this.description,
    this.category,
    this.image,
    this.page,
  );
}

class ToolCategory {
  static String ia = "Intelligence Artificielle";
  static String drole = "Drole";
  static String divertissement = "Divertissement";
}
