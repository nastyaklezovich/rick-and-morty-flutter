import 'package:flutter/material.dart';
import 'package:rick_and_morty/constants/app_border_radius.dart';
import 'package:rick_and_morty/constants/app_padding.dart';
import 'package:rick_and_morty/domain/entities/character/character_entity.dart';
import 'package:rick_and_morty/domain/entities/character/character_status.dart';
import 'package:rick_and_morty/presentation/character/widgets/character_info_row.dart';
import 'package:rick_and_morty/presentation/widgets/image_placeholder.dart';
import 'package:rick_and_morty/utils/extensions/string_extension.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({
    required this.character,
    Key? key,
  }) : super(key: key);

  final CharacterEntity character;

  static Route<dynamic> route({
    required CharacterEntity character,
  }) =>
      MaterialPageRoute<void>(
        builder: (_) => CharacterPage(
          character: character,
        ),
      );

  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  CharacterEntity get character => widget.character;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('CharacterEntity'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.medium,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 16,
                ),
                AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: AppBorderRadius.small,
                    child: Image.network(
                      character.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (
                        BuildContext context,
                        Object exception,
                        StackTrace? stackTrace,
                      ) =>
                          const ImagePlaceholder(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  character.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  character.status.name.capitalize(),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: character.status.getStatusColor(),
                      ),
                ),
                const Divider(),
                CharacterInfoRow(
                  title: 'Species',
                  value: character.species,
                ),
                const SizedBox(
                  height: 4,
                ),
                CharacterInfoRow(
                  title: 'Gender',
                  value: character.gender.name.capitalize(),
                ),
                const SizedBox(
                  height: 4,
                ),
                CharacterInfoRow(
                  title: 'Type',
                  value: character.type,
                ),
              ],
            ),
          ),
        ),
      );
}
