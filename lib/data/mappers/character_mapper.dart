import 'package:rick_and_morty/data/models/character_response/character_response.dart';
import 'package:rick_and_morty/domain/entities/character/character.dart';
import 'package:rick_and_morty/domain/entities/character/character_gender.dart';
import 'package:rick_and_morty/domain/entities/character/character_status.dart';

class CharacterMapper {
  static Character fromResponse({required CharacterResponse response}) =>
      Character(
        id: response.id,
        name: response.name ?? 'Unknown',
        status: CharacterStatus.values.byName(
          response.status?.toLowerCase() ?? 'empty',
        ),
        species: response.species ?? 'Unknown',
        type: response.type ?? 'Unknown',
        gender: CharacterGender.values.byName(
          response.gender?.toLowerCase() ?? 'empty',
        ),
        imageUrl: response.image ?? '',
        created: response.created,
      );
}
