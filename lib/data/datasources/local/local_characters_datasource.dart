import 'package:rick_and_morty/data/models/character_model/character_model.dart';

abstract class LocalCharactersDatasource {
  Future<List<CharacterModel>> fetchCharacters(
    Map<String, dynamic> queryParams,
  );

  Future<void> cacheCharacters(
    List<CharacterModel> models,
  );
}
