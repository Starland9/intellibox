import 'package:intellibox_v2/src/utils/logic.dart';
import 'package:json_annotation/json_annotation.dart';

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
}
