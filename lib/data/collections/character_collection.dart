import 'package:isar/isar.dart';

part 'character_collection.g.dart';

@Collection()
class Character {
  Id? id;

  String? name;
  String? status;
  int? age;
  bool? isLiked;

  Character({
    this.id,
    this.name,
    this.status,
    this.age,
  });
}
