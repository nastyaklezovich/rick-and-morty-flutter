import 'package:freezed_annotation/freezed_annotation.dart';

part 'character_response.freezed.dart';

part 'character_response.g.dart';

@freezed
class CharacterResponse with _$CharacterResponse {
  const factory CharacterResponse({
    required int id,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
    String? image,
    String? url,
    String? created,
  }) = _CharacterResponse;

  factory CharacterResponse.fromJson(Map<String, Object?> json) =>
      _$CharacterResponseFromJson(json);
}
