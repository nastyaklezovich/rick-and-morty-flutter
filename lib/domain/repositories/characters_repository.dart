import 'package:dartz/dartz.dart';

import '../../utils/error/failure.dart';
import '../entities/character/character_entity.dart';

abstract class CharactersRepository {
  Future<Either<Failure, List<CharacterEntity>>> fetchCharacters(
    Map<String, dynamic> queryParams,
  );
}
