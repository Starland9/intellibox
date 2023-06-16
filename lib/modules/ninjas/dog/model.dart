import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Dog {
  final String name;
  final String imageLink;
  final double goodWithChildren;
  final double goodWithOtherDogs;
  final double shedding;
  final double grooming;
  final double drooling;
  final double coatLength;
  final double goodWithStrangers;
  final double playfulness;
  final double protectiveness;
  final double trainability;
  final double energy;
  final double barking;
  final double minLifeExpectancy;
  final double maxLifeExpectancy;
  final double maxHeightMale;
  final double maxHeightFemale;
  final double maxWeightMale;
  final double maxWeightFemale;

  Dog({
    required this.name,
    required this.imageLink,
    required this.goodWithChildren,
    required this.goodWithOtherDogs,
    required this.shedding,
    required this.grooming,
    required this.drooling,
    required this.coatLength,
    required this.goodWithStrangers,
    required this.playfulness,
    required this.protectiveness,
    required this.trainability,
    required this.energy,
    required this.barking,
    required this.minLifeExpectancy,
    required this.maxLifeExpectancy,
    required this.maxHeightMale,
    required this.maxHeightFemale,
    required this.maxWeightMale,
    required this.maxWeightFemale,
  });

  factory Dog.fromJson(Map<String, dynamic> json) => _$DogFromJson(json);
  Map<String, dynamic> toJson() => _$DogToJson(this);
}
