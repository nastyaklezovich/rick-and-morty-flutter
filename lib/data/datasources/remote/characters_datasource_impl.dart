import 'package:rick_and_morty/data/clients/rest_client.dart';
import 'package:rick_and_morty/data/datasources/remote/characters_datasource.dart';
import 'package:rick_and_morty/data/models/character_response/character_response.dart';
import 'package:rick_and_morty/data/models/characters_response/characters_response.dart';
import 'package:rick_and_morty/injection.dart';

class CharactersDatasourceImpl implements CharactersDatasource {
  CharactersDatasourceImpl({RestClient? client})
      : _client = client ?? getIt.get<RestClient>();

  final RestClient _client;

  @override
  Future<List<CharacterResponse>> fetchCharacters(
    Map<String, dynamic> queryParams,
  ) async {
    try {
      final CharactersResponse response =
          await _client.fetchCharacters(queryParams);
      return response.results;
    } on Exception catch (_) {
      rethrow;
    }
  }
}
