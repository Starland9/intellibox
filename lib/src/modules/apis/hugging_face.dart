import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:intellibox/src/utils/logic.dart';
import 'package:translator/translator.dart';

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
        headers: _getHds,
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

  Map<String, String> get _getHds {
    return {
      'Authorization': "Bearer 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 ",
      "Accept": "*/*",
      "Content-Type": "application/json",
    };
  }

  static Future? answerImage(File imageFile, String question) async {
    try {
      // Read the image file
      var imageBytes = await imageFile.readAsBytes();

      // Prepare the request headers and payload
      Map<String, String> headers = {
        'Authorization': 'Bearer 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 ',
        'Content-Type': 'application/octet-stream',
      };
      var apiUrl =
          HuggingFace()._getModel("nlpconnect/vit-gpt2-image-captioning");

      // Make the POST request
      http.Response response = await http.post(
        apiUrl,
        headers: headers,
        body: imageBytes,
      );

      if (response.statusCode == 200) {
        String text = jsonDecode(response.body)[0]["generated_text"];
        return await tr(text);
      } else {
        return 'Request failed with status code ${response.statusCode}';
      }
    } catch (e) {
      return null;
    }
  }
}
