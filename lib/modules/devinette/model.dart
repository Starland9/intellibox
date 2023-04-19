import 'package:json_annotation/json_annotation.dart';
import 'package:translator/translator.dart';

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

  static Future<Devinette> translated(Devinette d) async{
  var t = await d.title.translate(to: "fr");
  var q = await d.question.translate(to: "fr");
  var a = await d.answer.translate(to: "fr");
    return Devinette(t.text, q.text, a.text);
  }
}
