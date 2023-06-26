import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_and_morty/domain/entities/character/character_status.dart';

part 'character_status_chip.freezed.dart';

@freezed
class CharacterStatusChip with _$CharacterStatusChip {
  const factory CharacterStatusChip({
    required CharacterStatus status,
    @Default(false) bool isSelected,
    @Default(false) bool initialValue,
  }) = _CharacterStatusChip;
}