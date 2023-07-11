import 'package:isar/isar.dart';
import 'package:rick_and_morty/data/collections/character_collection.dart';
import 'package:rick_and_morty/data/datasources/local/local_characters_datasource.dart';
import 'package:rick_and_morty/data/models/character_model/character_model.dart';
import 'package:rick_and_morty/injection.dart';

class LocalCharactersDatasourceImpl implements LocalCharactersDatasource {
  LocalCharactersDatasourceImpl({Isar? isar})
      : _isar = isar ?? getIt.get<Isar>();

  final Isar _isar;

  @override
  Future<List<CharacterModel>> fetchCharacters(
    Map<String, dynamic> queryParams,
  ) async {
    try {
      final charcters = await _isar.characters;
      return <CharacterModel>[];
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> cacheCharacters(List<CharacterModel> models) {
    // TODO: implement cacheCharacters
    throw UnimplementedError();
  }
}
