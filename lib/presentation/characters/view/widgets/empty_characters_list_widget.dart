import 'package:flutter/material.dart';

class EmptyCharactersList extends StatelessWidget {
  const EmptyCharactersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Center(
        child: Text('Empty list of characters'),
      );
}
