import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:rick_and_morty/injection.dart';
import 'package:rick_and_morty/presentation/characters/store/characters_store.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({Key? key}) : super(key: key);

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final CharactersStore _charactersStore = getIt.get<CharactersStore>();

  late final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) => Expanded(
        child: Observer(
          builder: (_) => TextField(
            controller: searchController,
            onChanged: (String value) => _charactersStore.name = value,
            onSubmitted: (String value) => _charactersStore.fetchCharacters(),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Search',
              prefixIcon: const Icon(
                Icons.search,
              ),
              suffixIcon: _charactersStore.name.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        searchController.clear();
                        _charactersStore
                          ..name = ''
                          ..fetchCharacters();
                      },
                      icon: const Icon(
                        Icons.close,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ),
      );

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
