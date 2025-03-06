// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisageDetect _$VisageDetectFromJson(Map<String, dynamic> json) => VisageDetect(
      (json['x'] as num).toInt(),
      (json['y'] as num).toInt(),
      (json['width'] as num).toInt(),
      (json['height'] as num).toInt(),
    );

Map<String, dynamic> _$VisageDetectToJson(VisageDetect instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'width': instance.width,
      'height': instance.height,
    };
