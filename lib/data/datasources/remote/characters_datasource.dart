
import 'package:rick_and_morty/data/models/character_response/character_response.dart';

abstract class CharactersDatasource {
  Future<List<CharacterResponse>> fetchCharacters(
    Map<String, dynamic> queryParams,
  );
}
