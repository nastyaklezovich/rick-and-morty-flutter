import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:rick_and_morty/data/models/characters_response/characters_response.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('character')
  Future<CharactersResponse> fetchCharacters(
    @Queries() Map<String, dynamic> queryParams,
  );
}
