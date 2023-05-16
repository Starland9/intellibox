import 'dart:convert';
import 'dart:io';

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
      'Authorization': "Bearer ${ApiKeys.huggingFace}",
      "Accept": "*/*",
      "Content-Type": "application/json",
    };
  }

  static Future? answerImage(File imageFile, String question) async {
    try {
      var byte = await imageFile.readAsBytes();
      var file = http.MultipartFile.fromBytes(
        "image",
        byte,
        filename: imageFile.path,
      );

      var q = http.MultipartRequest(
        "POST",
        HuggingFace()._getModel("dandelin/vilt-b32-finetuned-vqa"),
      );

      q.files.add(file);
      q.headers['Authorization'] = "Bearer ${ApiKeys.huggingFace}";
      q.headers['Accept'] = "*/*";
      q.headers['Content-Type'] = "application/json";
      q.fields["question"] = question;

      var r = await q.send();
      var rString = await r.stream.bytesToString();
      Map m = jsonDecode(rString);
      print(m);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
