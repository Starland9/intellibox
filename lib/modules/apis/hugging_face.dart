import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:translator/translator.dart';

import '../../.env/keys.dart';

class HuggingFace {
  static const modelsUrl = "https://api-inference.huggingface.co/models/";

  Uri _getModel(String modelName) {
    return Uri.parse(modelsUrl + modelName);
  }

  Future generateImage(String text, String? model) async {
    try {
      String translated = (await text.translate()).text;
      var r = await http.post(
        _getModel(model ?? "stabilityai/stable-diffusion-2-1"),
        headers: {
          'Authorization': "Bearer ${ApiKeys.huggingFace}",
          "Accept": "*/*",
          "Content-Type": "application/json",
        },
        body: jsonEncode(translated),
      );
      try {
        Map m = jsonDecode(r.body);
        if (m['error'] != null) {
          if (model != null) {
            return "Notre robot est actuellement indisponible, veuillez reessayer dans environ ${m['estimated_time']} minutes";
          }
          return generateImage(text, "runwayml/stable-diffusion-v1-5");
        }
      } catch (e) {
        return r.bodyBytes;
      }
    } catch (e) {
      return null;
    }
  }
}
