import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/domain/entities/character/character_entity.dart';
import 'package:rick_and_morty/domain/repositories/characters_repository.dart';
import 'package:rick_and_morty/utils/error/failure.dart';
import 'package:rick_and_morty/utils/use_case/use_case.dart';

class FetchCharactersUseCase
    extends UseCase<List<CharacterEntity>, FetchCharactersParams> {
  final CharactersRepository charactersRepository;

  FetchCharactersUseCase(this.charactersRepository);

  @override
  Future<Either<Failure, List<CharacterEntity>>> call(FetchCharactersParams params) =>
      charactersRepository.fetchCharacters(params.queryParams);
}

class FetchCharactersParams {
  final Map<String, dynamic> queryParams;

  FetchCharactersParams(this.queryParams);
}
