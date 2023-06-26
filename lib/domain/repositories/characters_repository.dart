import 'package:dartz/dartz.dart';

import '../../utils/error/failure.dart';
import '../entities/character/character.dart';

abstract class CharactersRepository {
  Future<Either<Failure, List<Character>>> fetchCharacters(
    Map<String, dynamic> queryParams,
  );
}
