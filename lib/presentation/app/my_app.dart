import 'package:flutter/material.dart';
import 'package:rick_and_morty/presentation/characters/view/characters_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Rick and Morty',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: const CharactersPage(),
        ),
      );
}
