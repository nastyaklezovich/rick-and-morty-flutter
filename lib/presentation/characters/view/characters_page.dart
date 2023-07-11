import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:rick_and_morty/constants/app_padding.dart';
import 'package:rick_and_morty/domain/entities/character/character_entity.dart';
import 'package:rick_and_morty/injection.dart';
import 'package:rick_and_morty/presentation/characters/store/characters_store.dart';
import 'package:rick_and_morty/presentation/characters/view/widgets/character_card.dart';
import 'package:rick_and_morty/presentation/characters/view/widgets/empty_characters_list_widget.dart';
import 'package:rick_and_morty/presentation/characters/view/widgets/error_message_widget.dart';
import 'package:rick_and_morty/presentation/characters/view/widgets/filters_bottom_sheet.dart';
import 'package:rick_and_morty/presentation/characters/view/widgets/loader.dart';
import 'package:rick_and_morty/presentation/characters/view/widgets/search_text_field.dart';
import 'package:rick_and_morty/utils/error/failure.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  final CharactersStore _charactersStore = getIt.get<CharactersStore>();

  @override
  void initState() {
    super.initState();
    fetchCharacters();
    _charactersStore.initFilters();
  }

  Future<void> fetchCharacters() async {
    await _charactersStore.fetchCharacters();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Characters'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppPadding.small,
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  left: AppPadding.medium,
                  right: AppPadding.medium,
                  bottom: AppPadding.medium,
                ),
                child: Row(
                  children: <Widget>[
                    const SearchTextField(),
                    const SizedBox(
                      width: 8,
                    ),
                    IconButton.filledTonal(
                      onPressed: () {
                        showModalBottomSheet<bool>(
                          context: context,
                          showDragHandle: true,
                          builder: (_) => const FiltersBottomSheet(),
                        ).then((bool? value) {
                          if (value != null && value) {
                            print('was changed');
                          } else {
                            _charactersStore.discardFilterChanges();
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.filter_list_outlined,
                      ),
                    ),
                  ],
                ),
              ),
              Observer(
                builder: (_) {
                  final ObservableFuture<Either<Failure, List<CharacterEntity>>>?
                      future = _charactersStore.charactersFuture;

                  if (future == null) {
                    return const Loader();
                  }

                  switch (future.status) {
                    case FutureStatus.pending:
                      return const Loader();

                    case FutureStatus.rejected:
                      return ErrorMessageWidget(
                        refresh: _charactersStore.fetchCharacters,
                      );

                    case FutureStatus.fulfilled:
                      final String? error = _charactersStore.errorMessage;
                      final List<CharacterEntity> characters =
                          _charactersStore.characters;
                      if (error != null) {
                        return ErrorMessageWidget(
                          refresh: _charactersStore.fetchCharacters,
                        );
                      } else if (characters.isEmpty) {
                        return const EmptyCharactersList();
                      } else {
                        return Expanded(
                          child: RefreshIndicator(
                            onRefresh: _charactersStore.fetchCharacters,
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: characters.length,
                              itemBuilder: (_, int index) => CharacterCard(
                                character: characters[index],
                              ),
                              separatorBuilder: (_, __) => const SizedBox(
                                height: 8,
                              ),
                            ),
                          ),
                        );
                      }
                  }
                },
              ),
            ],
          ),
        ),
      );
}
