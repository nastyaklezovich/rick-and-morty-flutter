import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:rick_and_morty/constants/app_padding.dart';
import 'package:rick_and_morty/injection.dart';
import 'package:rick_and_morty/presentation/characters/models/character_gender_chip.dart';
import 'package:rick_and_morty/presentation/characters/models/character_status_chip.dart';
import 'package:rick_and_morty/presentation/characters/store/characters_store.dart';
import 'package:rick_and_morty/utils/extensions/string_extension.dart';

class FiltersBottomSheet extends StatefulWidget {
  const FiltersBottomSheet({Key? key}) : super(key: key);

  @override
  State<FiltersBottomSheet> createState() => _FiltersBottomSheetState();
}

class _FiltersBottomSheetState extends State<FiltersBottomSheet> {
  final CharactersStore _charactersStore = getIt.get<CharactersStore>();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(
          AppPadding.medium,
          AppPadding.small,
          AppPadding.medium,
          AppPadding.medium,
        ),
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('Gender: '),
                  const SizedBox(
                    height: 8,
                  ),
                  Observer(
                    builder: (_) => Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _charactersStore.characterGenderChips
                          .map<Widget>(
                            (CharacterGenderChip characterGenderChip) =>
                                FilterChip(
                              selected: characterGenderChip.isSelected,
                              onSelected: (bool isSelected) {
                                _charactersStore.selectGender(
                                  characterGenderChip,
                                  isSelected: isSelected,
                                );
                              },
                              label: Text(
                                characterGenderChip.gender.name.capitalize(),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text('Status: '),
                  const SizedBox(
                    height: 8,
                  ),
                  Observer(
                    builder: (_) => Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _charactersStore.characterStatusChips
                          .map(
                            (CharacterStatusChip characterStatusChip) =>
                                FilterChip(
                              selected: characterStatusChip.isSelected,
                              onSelected: (bool isSelected) {
                                _charactersStore.selectStatus(
                                  characterStatusChip,
                                  isSelected: isSelected,
                                );
                              },
                              label: Text(
                                characterStatusChip.status.name.capitalize(),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        _charactersStore.fetchCharacters();
                        Navigator.of(context).pop(true);
                      },
                      child: const Text(
                        'Apply',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: _charactersStore.resetFilters,
                      child: const Text(
                        'Discard',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
