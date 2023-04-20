import 'dart:convert';

import 'package:intellibox/utils/logic.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;

import '../../.env/keys.dart';

part 'model.g.dart';

@JsonSerializable()
class Devinette {
  final String title;
  final String question;
  final String answer;

  Devinette(this.title, this.question, this.answer);

  factory Devinette.fromJson(Map<String, dynamic> json) =>
      _$DevinetteFromJson(json);
  Map<String, dynamic> toJson() => _$DevinetteToJson(this);

  static Future<Devinette> translated(Devinette d) async {
    return Devinette(
      await tr(d.title),
      await tr(d.question),
      await tr(d.answer),
    );
  }



  // 
  static Future<Devinette?> getDevinette(int? limit) async {
    try {
      var r = await http
          .get(Uri.parse("https://api.api-ninjas.com/v1/riddles"), headers: {
        if (limit != null) "limit": limit.toString(),
        'X-Api-Key': ApiKeys.ninja,
      });

      return Devinette.fromJson(jsonDecode(r.body)[0]);
    } catch (e) {
      return null;
    }
  }
}
