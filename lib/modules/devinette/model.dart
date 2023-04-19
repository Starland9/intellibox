import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class Devinette {
  final String title;
  final String question;
  final String answer;

  Devinette(this.title, this.question, this.answer);

  factory Devinette.fromJson(Map<String, dynamic> json) => _$DevinetteFromJson(json);
  Map<String, dynamic> toJson() => _$DevinetteToJson(this);
}
