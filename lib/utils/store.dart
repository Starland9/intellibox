// ignore_for_file: prefer_const_constructors

import 'package:intellibox/modules/devinette/view.dart';
import 'package:intellibox/modules/visage_detect/view.dart';
import 'package:intellibox/utils/assets.dart';

import '../models/tool/tool.dart';
import '../modules/mood/view.dart';

class AppStore {
  static List<Tool> tools = [
    Tool(
      "Générateur de devinêttes",
      "",
      ToolCategory.drole,
      SImages.devinetteLogo,
      DevinettePage(),
    ),
    //
    Tool(
      "Détecteur d'émotion",
      "",
      ToolCategory.divertissement,
      SImages.sentimentLogo,
      MoodPage(),
    ),
    //
    Tool(
      "Détecteur de visage",
      "",
      ToolCategory.divertissement,
      SImages.sentimentLogo,
      VisageDetectPage(),
    ),
  ];

  static String locale = "fr";
}
