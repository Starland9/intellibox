import 'package:intellibox_v2/src/utils/logic.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class Mood {
  double score;
  String text;
  String sentiment;

  Mood({
    required this.score,
    required this.text,
    required this.sentiment,
  });

  factory Mood.fromJson(Map<String, dynamic> json) => _$MoodFromJson(json);
  Map<String, dynamic> toJson() => _$MoodToJson(this);

  static Future<Mood?> translated(Mood mood) async {
    return Mood(
        score: (mood.score),
        text: await tr(mood.text),
        sentiment: await tr(mood.sentiment));
  }
}
