// ignore_for_file: prefer_const_constructors

import 'package:intellibox/src/modules/huggingFace/bot/intellibot_page.dart';
import 'package:intellibox/src/modules/huggingFace/text_to_image/stable_diffusion/view.dart';
import 'package:intellibox/src/utils/assets.dart';

import '../models/tool/tool.dart';
import '../modules/huggingFace/image_answer/view.dart';
import '../modules/ninjas/detectors/object_detect/view.dart';
import '../modules/ninjas/detectors/visage_detect/view.dart';
import '../modules/ninjas/devinette/view.dart';
import '../modules/ninjas/dog/view.dart';
import '../modules/ninjas/mood/view.dart';

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
    //
    Tool(
      "Analyseur d'image",
      "",
      ToolCategory.divertissement,
      SImages.answerImageLogo,
      ImageAnswer(),
    ),
    //
    Tool(
      "IntelliBot",
      "",
      ToolCategory.ia,
      SImages.botImageLogo,
      IntelliBotPage(),
    ),
  ];

  static String locale = "fr";
}
