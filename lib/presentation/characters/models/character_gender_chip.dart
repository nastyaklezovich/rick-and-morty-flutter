import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_and_morty/domain/entities/character/character_gender.dart';

part 'character_gender_chip.freezed.dart';

@freezed
class CharacterGenderChip with _$CharacterGenderChip {
  const factory CharacterGenderChip({
    required CharacterGender gender,
    @Default(false) bool isSelected,
    @Default(false) bool initialValue,
  }) = _CharacterGenderChip;
}
