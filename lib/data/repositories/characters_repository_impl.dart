import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/data/datasources/remote/characters_datasource.dart';
import 'package:rick_and_morty/data/datasources/remote/characters_datasource_impl.dart';
import 'package:rick_and_morty/data/mappers/character_mapper.dart';
import 'package:rick_and_morty/data/models/character_response/character_response.dart';
import 'package:rick_and_morty/domain/entities/character/character.dart';
import 'package:rick_and_morty/domain/repositories/characters_repository.dart';
import 'package:rick_and_morty/utils/error/failure.dart';

@Injectable(as: CharactersRepository)
class CharactersRepositoryImpl implements CharactersRepository {
  CharactersRepositoryImpl({
    CharactersDatasource? charactersDatasource,
  }) : _charactersDatasource =
            charactersDatasource ?? CharactersDatasourceImpl();

  final CharactersDatasource _charactersDatasource;

  @override
  Future<Either<Failure, List<Character>>> fetchCharacters(
    Map<String, dynamic> queryParams,
  ) async {
    try {
      final List<CharacterResponse> response =
          await _charactersDatasource.fetchCharacters(queryParams);

      final List<Character> characters = <Character>[];

      for (final CharacterResponse characterResponse in response) {
        characters.add(
          CharacterMapper.fromResponse(
            response: characterResponse,
          ),
        );
      }

      return Right(characters);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
