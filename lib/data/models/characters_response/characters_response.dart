import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_and_morty/data/models/character_response/character_response.dart';

part 'characters_response.freezed.dart';
part 'characters_response.g.dart';

@freezed
class CharactersResponse with _$CharactersResponse {
  const factory CharactersResponse({
    @Default(<CharacterResponse>[]) List<CharacterResponse> results,
  }) = _CharactersResponse;

  factory CharactersResponse.fromJson(Map<String, Object?> json) =>
      _$CharactersResponseFromJson(json);
}
