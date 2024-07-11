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

  String get friendlyText {
    return '''
      Salut! Je suis $name, et voici quelques informations sur moi:
      - J'adore jouer avec des enfants: $goodWithChildren
      - J'aime aussi passer du temps avec d'autres chiens: $goodWithOtherDogs
      - Mon niveau de perte de poil est: $shedding
      - J'ai besoin de beaucoup de toilettage: $grooming
      - Je bave un peu: $drooling
      - La longueur de mon pelage est: $coatLength
      - Je suis bon avec les étrangers: $goodWithStrangers
      - J'aime m'amuser: $playfulness
      - Je suis protecteur: $protectiveness
      - Je suis facile à entraîner: $trainability
      - J'ai beaucoup d'énergie: $energy
      - Je n'aboie pas beaucoup: $barking
      - Mon espérance de vie minimale est: $minLifeExpectancy
      - Mon espérance de vie maximale est: $maxLifeExpectancy
      - Ma taille maximale (mâle) est: $maxHeightMale
      - Ma taille maximale (femelle) est: $maxHeightFemale
      - Mon poids maximal (mâle) est: $maxWeightMale
      - Mon poids maximal (femelle) est: $maxWeightFemale
    ''';
  }
}
