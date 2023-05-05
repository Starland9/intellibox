// ignore_for_file: prefer_const_constructors

import 'package:intellibox/modules/devinette/view.dart';
import 'package:intellibox/modules/dog/view.dart';
import 'package:intellibox/modules/object_detect/view.dart';
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
      SImages.visageLogo,
      VisageDetectPage(),
    ),
    //
    Tool(
      "Inpecteur de chiens",
      "",
      ToolCategory.divertissement,
      SImages.dogLogo,
      DogPage(),
    ),
    //
    Tool(
      "Detecteur d'objets",
      "",
      ToolCategory.divertissement,
      SImages.objectDetectLogo,
      ObjectDetect(),
    ),
  ];

  static String locale = "fr";
}
