import 'package:flutter/material.dart';

class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget({required this.refresh, Key? key}) : super(key: key);

  final VoidCallback refresh;

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Failed to load items',
            ),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              child: const Text('Tap to try again'),
              onPressed: refresh,
            )
          ],
        ),
      );
}
