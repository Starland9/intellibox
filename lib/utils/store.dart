// ignore_for_file: prefer_const_constructors

import 'package:intellibox/modules/devinette/view.dart';
import 'package:intellibox/modules/dog/view.dart';
import 'package:intellibox/modules/text_to_image/stable_diffusion/view.dart';
import 'package:intellibox/utils/assets.dart';

import '../models/tool/tool.dart';
import '../modules/detectors/object_detect/view.dart';
import '../modules/detectors/visage_detect/view.dart';
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
    //
    Tool(
      "Générateur d'image",
      "",
      ToolCategory.divertissement,
      SImages.imageGen1Logo,
      ImageGen1(),
    ),
  ];

  static String locale = "fr";
}
