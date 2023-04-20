// ignore_for_file: prefer_const_constructors

import 'package:intellibox/modules/devinette/view.dart';
import 'package:intellibox/utils/assets.dart';

import '../models/tool/tool.dart';

class AppStore {
  static List<Tool> tools = [
    Tool(
      "Générateur de devinêttes",
      "",
      ToolCategory.drole,
      SImages.devinetteLogo,
      DevinettePage(),
    ),
    Tool(
      "Détecteur d'émotion",
      "",
      ToolCategory.divertissement,
      SImages.sentimentLogo,
      null,
    ),
  ];

  static String locale = "fr";
}
