import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class VisageDetect {
  final int x;
  final int y;
  final int width;
  final int height;

  VisageDetect(
    this.x,
    this.y,
    this.width,
    this.height,
  );

  factory VisageDetect.fromJson(Map<String, dynamic> json) =>
      _$VisageDetectFromJson(json);
  Map<String, dynamic> toJson() => _$VisageDetectToJson(this);
}
