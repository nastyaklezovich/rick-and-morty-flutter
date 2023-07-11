import 'package:freezed_annotation/freezed_annotation.dart';

part 'character_model.freezed.dart';

part 'character_model.g.dart';

@freezed
class CharacterModel with _$CharacterModel {
  const factory CharacterModel({
    required int id,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
    String? image,
    String? url,
    String? created,
  }) = _CharacterModel;

  factory CharacterModel.fromJson(Map<String, Object?> json) =>
      _$CharacterModelFromJson(json);
}
