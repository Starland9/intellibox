// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dog _$DogFromJson(Map<String, dynamic> json) => Dog(
      name: json['name'] as String,
      imageLink: json['image_link'] as String,
      goodWithChildren: (json['good_with_children'] as num).toDouble(),
      goodWithOtherDogs: (json['good_with_other_dogs'] as num).toDouble(),
      shedding: (json['shedding'] as num).toDouble(),
      grooming: (json['grooming'] as num).toDouble(),
      drooling: (json['drooling'] as num).toDouble(),
      coatLength: (json['coat_length'] as num).toDouble(),
      goodWithStrangers: (json['good_with_strangers'] as num).toDouble(),
      playfulness: (json['playfulness'] as num).toDouble(),
      protectiveness: (json['protectiveness'] as num).toDouble(),
      trainability: (json['trainability'] as num).toDouble(),
      energy: (json['energy'] as num).toDouble(),
      barking: (json['barking'] as num).toDouble(),
      minLifeExpectancy: (json['min_life_expectancy'] as num).toDouble(),
      maxLifeExpectancy: (json['max_life_expectancy'] as num).toDouble(),
      maxHeightMale: (json['max_height_male'] as num).toDouble(),
      maxHeightFemale: (json['max_height_female'] as num).toDouble(),
      maxWeightMale: (json['max_weight_male'] as num).toDouble(),
      maxWeightFemale: (json['max_weight_female'] as num).toDouble(),
    );

Map<String, dynamic> _$DogToJson(Dog instance) => <String, dynamic>{
      'name': instance.name,
      'image_link': instance.imageLink,
      'good_with_children': instance.goodWithChildren,
      'good_with_other_dogs': instance.goodWithOtherDogs,
      'shedding': instance.shedding,
      'grooming': instance.grooming,
      'drooling': instance.drooling,
      'coat_length': instance.coatLength,
      'good_with_strangers': instance.goodWithStrangers,
      'playfulness': instance.playfulness,
      'protectiveness': instance.protectiveness,
      'trainability': instance.trainability,
      'energy': instance.energy,
      'barking': instance.barking,
      'min_life_expectancy': instance.minLifeExpectancy,
      'max_life_expectancy': instance.maxLifeExpectancy,
      'max_height_male': instance.maxHeightMale,
      'max_height_female': instance.maxHeightFemale,
      'max_weight_male': instance.maxWeightMale,
      'max_weight_female': instance.maxWeightFemale,
    };
