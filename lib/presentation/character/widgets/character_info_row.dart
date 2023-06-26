import 'package:flutter/material.dart';

class CharacterInfoRow extends StatelessWidget {
  const CharacterInfoRow({
    required this.title,
    this.value,
    Key? key,
  }) : super(key: key);

  final String title;
  final String? value;

  @override
  Widget build(BuildContext context) => RichText(
        text: TextSpan(
          text: '$title: ',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.black45,
              ),
          children: <TextSpan>[
            TextSpan(
              text: value != null && value!.isNotEmpty ? value : 'Unknown',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      );
}
