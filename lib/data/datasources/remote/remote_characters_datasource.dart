import 'package:rick_and_morty/data/models/character_model/character_model.dart';

abstract class RemoteCharactersDatasource {
  Future<List<CharacterModel>> fetchCharacters(
    Map<String, dynamic> queryParams,
  );
}
