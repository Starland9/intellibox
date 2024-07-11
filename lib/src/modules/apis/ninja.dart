import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:translator/translator.dart';

import '../../utils/logic.dart';
import '../ninjas/detectors/object_detect/model.dart';
import '../ninjas/detectors/visage_detect/model.dart';
import '../ninjas/devinette/model.dart';
import '../ninjas/dog/model.dart';
import '../ninjas/mood/model.dart';

class Ninja {
  //
  static Future<Devinette?> getDevinette(int? limit) async {
    try {
      var r = await http.get(getEndPoint("riddles"), headers: {
        if (limit != null) "limit": limit.toString(),
        'X-Api-Key': "Uo6DyVrhfSYiiqWtDXpF9BpBdu657qMhEyVlPFOO",
      });

      return Devinette.fromJson(jsonDecode(r.body)[0]);
    } catch (e) {
      return null;
    }
  }

  static Future<Mood?> getMood(String text) async {
    try {
      var r = await http.get(getEndPoint("sentiment?text=$text"), headers: {
        'X-Api-Key': "Uo6DyVrhfSYiiqWtDXpF9BpBdu657qMhEyVlPFOO",
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
      q.headers['X-Api-Key'] = "Uo6DyVrhfSYiiqWtDXpF9BpBdu657qMhEyVlPFOO";

      var r = await q.send();
      var rString = await r.stream.bytesToString();
      return List.from(jsonDecode(rString))
          .map((e) => VisageDetect.fromJson(e))
          .toList();
    } catch (e) {
      return null;
    }
  }

  static Future<List<AnObject>?> objectDetect(File imageFile) async {
    try {
      var byte = await imageFile.readAsBytes();
      var file = http.MultipartFile.fromBytes(
        "image",
        byte,
        filename: imageFile.path,
      );

      var q = http.MultipartRequest("POST", getEndPoint("objectdetection"));

      q.files.add(file);
      q.headers['X-Api-Key'] = "Uo6DyVrhfSYiiqWtDXpF9BpBdu657qMhEyVlPFOO";

      var r = await q.send();
      var rString = await r.stream.bytesToString();
      List<AnObject> list = List.from(jsonDecode(rString))
          .map((e) => AnObject.fromJson(e))
          .toList();

      List<AnObject>? translated = [];
      for (var element in list) {
        translated.add(await AnObject.translated(element));
      }
      return translated;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Dog>?> getDog(String name) async {
    try {
      String enName = (await name.translate(to: "en")).text;
      var r = await http.get(getEndPoint("dogs?name=$enName"), headers: {
        'X-Api-Key': "Uo6DyVrhfSYiiqWtDXpF9BpBdu657qMhEyVlPFOO",
      });
      return List.from(jsonDecode(r.body)).map((e) => Dog.fromJson(e)).toList();
    } catch (e) {
      return null;
    }
  }
}
