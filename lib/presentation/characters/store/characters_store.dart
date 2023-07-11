import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:rick_and_morty/domain/entities/character/character_entity.dart';
import 'package:rick_and_morty/domain/entities/character/character_gender.dart';
import 'package:rick_and_morty/domain/entities/character/character_status.dart';
import 'package:rick_and_morty/domain/use_cases/fetch_characters_use_case.dart';
import 'package:rick_and_morty/presentation/characters/models/character_gender_chip.dart';
import 'package:rick_and_morty/presentation/characters/models/character_status_chip.dart';
import 'package:rick_and_morty/utils/error/failure.dart';

part 'characters_store.g.dart';

class CharactersStore = _CharactersStore with _$CharactersStore;

abstract class _CharactersStore with Store {
  _CharactersStore({
    required this.fetchCharactersUseCase,
  });

  final FetchCharactersUseCase fetchCharactersUseCase;

  @observable
  ObservableFuture<Either<Failure, List<CharacterEntity>>>? charactersFuture;

  @observable
  List<CharacterEntity> characters = ObservableList<CharacterEntity>();

  @observable
  String? errorMessage;

  @observable
  String name = '';

  @observable
  List<CharacterGenderChip> characterGenderChips =
      ObservableList<CharacterGenderChip>();

  @observable
  List<CharacterStatusChip> characterStatusChips =
      ObservableList<CharacterStatusChip>();

  @observable
  bool filterChangesSaved = true;

  @action
  Future<void> fetchCharacters() async {
    applyFilters();

    final Map<String, dynamic> queryParams = <String, dynamic>{
      'name': name,
      'gender': characterGenderChips
          .where((CharacterGenderChip characterGenderChip) =>
              characterGenderChip.isSelected)
          .map((CharacterGenderChip characterGenderChip) =>
              characterGenderChip.gender.name)
          .toList(),
      'status': characterStatusChips
          .where((CharacterStatusChip characterStatusChip) =>
              characterStatusChip.isSelected)
          .map((CharacterStatusChip characterStatusChip) =>
              characterStatusChip.status.name)
          .toList(),
    };

    charactersFuture = ObservableFuture<Either<Failure, List<CharacterEntity>>>(
      fetchCharactersUseCase.call(
        FetchCharactersParams(queryParams),
      ),
    );

    final Either<Failure, List<CharacterEntity>> either = await charactersFuture!;

    either.fold(
      (Failure failure) {
        errorMessage = failure.message;
        debugPrint(errorMessage);
      },
      (List<CharacterEntity> charactersFromServer) {
        errorMessage = null;
        characters
          ..clear()
          ..addAll(charactersFromServer);
      },
    );
  }

  @action
  void initFilters() {
    for (final CharacterGender characterGender in CharacterGender.values) {
      characterGenderChips.add(
        CharacterGenderChip(gender: characterGender),
      );
    }
    for (final CharacterStatus characterStatus in CharacterStatus.values) {
      characterStatusChips.add(
        CharacterStatusChip(status: characterStatus),
      );
    }
  }

  @action
  void selectGender(
    CharacterGenderChip selectedCharacterGenderChip, {
    bool isSelected = true,
  }) {
    characterGenderChips = characterGenderChips
        .map(
          (CharacterGenderChip characterGenderChip) =>
              selectedCharacterGenderChip.gender == characterGenderChip.gender
                  ? characterGenderChip.copyWith(isSelected: isSelected)
                  : characterGenderChip,
        )
        .toList();
  }

  @action
  void selectStatus(
    CharacterStatusChip selectedCharacterStatusChip, {
    bool isSelected = true,
  }) {
    characterStatusChips = characterStatusChips
        .map(
          (CharacterStatusChip characterStatusChip) =>
              selectedCharacterStatusChip.status == characterStatusChip.status
                  ? characterStatusChip.copyWith(isSelected: isSelected)
                  : characterStatusChip,
        )
        .toList();
  }

  @action
  void applyFilters() {
    characterGenderChips = characterGenderChips
        .map(
          (CharacterGenderChip characterGenderChip) =>
              characterGenderChip.copyWith(
            initialValue: characterGenderChip.isSelected,
          ),
        )
        .toList();

    characterStatusChips = characterStatusChips
        .map(
          (CharacterStatusChip characterStatusChip) =>
              characterStatusChip.copyWith(
            initialValue: characterStatusChip.isSelected,
          ),
        )
        .toList();
  }

  @action
  void discardFilterChanges() {
    characterGenderChips = characterGenderChips
        .map(
          (CharacterGenderChip characterGenderChip) =>
              characterGenderChip.copyWith(
            isSelected: characterGenderChip.initialValue,
          ),
        )
        .toList();

    characterStatusChips = characterStatusChips
        .map(
          (CharacterStatusChip characterStatusChip) =>
              characterStatusChip.copyWith(
            isSelected: characterStatusChip.initialValue,
          ),
        )
        .toList();
  }

  @action
  void resetFilters() {
    characterGenderChips = characterGenderChips
        .map(
          (CharacterGenderChip characterGenderChip) =>
              characterGenderChip.copyWith(
            isSelected: false,
          ),
        )
        .toList();

    characterStatusChips = characterStatusChips
        .map(
          (CharacterStatusChip characterStatusChip) =>
              characterStatusChip.copyWith(
            isSelected: false,
          ),
        )
        .toList();
  }
}
