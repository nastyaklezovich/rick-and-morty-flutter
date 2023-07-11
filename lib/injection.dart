import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rick_and_morty/constants/end_point.dart';
import 'package:rick_and_morty/data/clients/rest_client.dart';
import 'package:rick_and_morty/data/collections/character_collection.dart';
import 'package:rick_and_morty/data/repositories/characters_repository_impl.dart';
import 'package:rick_and_morty/domain/repositories/characters_repository.dart';
import 'package:rick_and_morty/domain/use_cases/fetch_characters_use_case.dart';
import 'package:rick_and_morty/presentation/characters/store/characters_store.dart';
import 'package:rick_and_morty/utils/dio/global_dio_module.dart';

final GetIt getIt = GetIt.instance;

void setup() {
  final Dio dio = dioBuilder(EndPoint.baseUrl);

  getIt
    ..registerLazySingleton<RestClient>(
      () => RestClient(
        dio,
      ),
    )
    ..registerSingletonAsync<Isar>(
      () async {
        final Directory dir = await getApplicationDocumentsDirectory();
        final Isar isar = await Isar.open(
          <CollectionSchema<dynamic>>[CharacterSchema],
          directory: dir.path,
          inspector: true,
        );
        return isar;
      },
    )
    ..registerFactory<CharactersRepository>(
      CharactersRepositoryImpl.new,
    )
    ..registerSingleton(
      FetchCharactersUseCase(
        getIt.get<CharactersRepository>(),
      ),
    )
    ..registerSingleton(
      CharactersStore(
        fetchCharactersUseCase: getIt.get<FetchCharactersUseCase>(),
      ),
    );
}
