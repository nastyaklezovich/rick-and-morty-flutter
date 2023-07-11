import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/data/datasources/remote/remote_characters_datasource.dart';
import 'package:rick_and_morty/data/datasources/remote/remote_characters_datasource_impl.dart';
import 'package:rick_and_morty/data/mappers/character_mapper.dart';
import 'package:rick_and_morty/data/models/character_model/character_model.dart';
import 'package:rick_and_morty/domain/entities/character/character_entity.dart';
import 'package:rick_and_morty/domain/repositories/characters_repository.dart';
import 'package:rick_and_morty/utils/error/failure.dart';

@Injectable(as: CharactersRepository)
class CharactersRepositoryImpl implements CharactersRepository {
  CharactersRepositoryImpl({
    RemoteCharactersDatasource? remoteCharactersDatasource,
  }) : _remoteCharactersDatasource =
            remoteCharactersDatasource ?? RemoteCharactersDatasourceImpl();

  final RemoteCharactersDatasource _remoteCharactersDatasource;

  @override
  Future<Either<Failure, List<CharacterEntity>>> fetchCharacters(
    Map<String, dynamic> queryParams,
  ) async {
    try {
      final List<CharacterModel> response =
          await _remoteCharactersDatasource.fetchCharacters(queryParams);

      final List<CharacterEntity> characters = <CharacterEntity>[];

      for (final CharacterModel characterResponse in response) {
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
