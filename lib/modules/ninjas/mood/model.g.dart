// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mood _$MoodFromJson(Map<String, dynamic> json) => Mood(
      score: (json['score'] as num).toDouble(),
      text: json['text'] as String,
      sentiment: json['sentiment'] as String,
    );

Map<String, dynamic> _$MoodToJson(Mood instance) => <String, dynamic>{
      'score': instance.score,
      'text': instance.text,
      'sentiment': instance.sentiment,
    };
