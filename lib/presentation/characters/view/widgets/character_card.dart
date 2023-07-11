import 'package:flutter/material.dart';
import 'package:rick_and_morty/constants/app_border_radius.dart';
import 'package:rick_and_morty/domain/entities/character/character_entity.dart';
import 'package:rick_and_morty/domain/entities/character/character_status.dart';
import 'package:rick_and_morty/presentation/character/view/character_page.dart';
import 'package:rick_and_morty/presentation/widgets/custom_card.dart';
import 'package:rick_and_morty/presentation/widgets/image_placeholder.dart';
import 'package:rick_and_morty/utils/extensions/string_extension.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({
    required this.character,
    Key? key,
  }) : super(key: key);

  final CharacterEntity character;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => Navigator.of(context).push<void>(
          CharacterPage.route(
            character: character,
          ),
        ),
        child: CustomCard(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: AppBorderRadius.small,
                child: Image.network(
                  character.imageUrl,
                  width: 52,
                  height: 52,
                  fit: BoxFit.cover,
                  errorBuilder: (
                    BuildContext context,
                    Object exception,
                    StackTrace? stackTrace,
                  ) =>
                      const ImagePlaceholder(size: 52),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      character.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 4,
                          backgroundColor: character.status.getStatusColor(),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          character.status.name.capitalize(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
