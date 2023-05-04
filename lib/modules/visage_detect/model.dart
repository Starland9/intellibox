import 'package:flutter/painting.dart';
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

  Size get size => Size(width.toDouble(), height.toDouble());
  Size get origin => Size(x.toDouble(), y.toDouble());

  factory VisageDetect.fromJson(Map<String, dynamic> json) =>
      _$VisageDetectFromJson(json);
  Map<String, dynamic> toJson() => _$VisageDetectToJson(this);
}
