import 'package:rick_and_morty/domain/entities/character/character_gender.dart';
import 'package:rick_and_morty/domain/entities/character/character_status.dart';

class CharacterEntity {
  final int id;
  final String name;
  final CharacterStatus status;
  final String species;
  final String type;
  final CharacterGender gender;
  final String imageUrl;
  final String? created;

  CharacterEntity({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.imageUrl,
    this.created,
  });
}
