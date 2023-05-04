import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:intellibox/.env/keys.dart';
import 'package:intellibox/modules/devinette/model.dart';
import 'package:intellibox/modules/visage_detect/model.dart';
import 'package:translator/translator.dart';

import '../../utils/logic.dart';
import '../dog/model.dart';
import '../mood/model.dart';

class Ninja {
  //
  static Future<Devinette?> getDevinette(int? limit) async {
    try {
      var r = await http.get(getEndPoint("riddles"), headers: {
        if (limit != null) "limit": limit.toString(),
        'X-Api-Key': ApiKeys.ninja,
      });

      return Devinette.fromJson(jsonDecode(r.body)[0]);
    } catch (e) {
      return null;
    }
  }

  static Future<Mood?> getMood(String text) async {
    try {
      var r = await http.get(getEndPoint("sentiment?text=$text"), headers: {
        'X-Api-Key': ApiKeys.ninja,
      });
      return Mood.fromJson(jsonDecode(r.body));
    } catch (e) {
      return null;
    }
  }

  static Future<List<VisageDetect>?> visageDetect(File imageFile) async {
    try {
      var byte = await imageFile.readAsBytes();
      var file = http.MultipartFile.fromBytes(
        "image",
        byte,
        filename: imageFile.path,
      );

      var q = http.MultipartRequest("POST", getEndPoint("facedetect"));

      q.files.add(file);
      q.headers['X-Api-Key'] = ApiKeys.ninja;

      var r = await q.send();
      var rString = await r.stream.bytesToString();
      return List.from(jsonDecode(rString))
          .map((e) => VisageDetect.fromJson(e))
          .toList();
    } catch (e) {
      return null;
    }
  }

  static Future<List<Dog>?> getDog(String name) async {
    try {
      String enName = (await name.translate(to: "en")).text;
      var r = await http.get(getEndPoint("dogs?name=$enName"), headers: {
        'X-Api-Key': ApiKeys.ninja,
      });
      return List.from(jsonDecode(r.body)).map((e) => Dog.fromJson(e)).toList();
    } catch (e) {
      return null;
    }
  }
}
