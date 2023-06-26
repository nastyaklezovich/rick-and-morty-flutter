import 'package:flutter/material.dart';

enum CharacterStatus {
  alive,
  dead,
  unknown,
}

extension CharacterStatusExtension on CharacterStatus {
  Color getStatusColor() {
    switch (this) {
      case CharacterStatus.alive:
        return Colors.green;
      case CharacterStatus.dead:
        return Colors.red;
      case CharacterStatus.unknown:
        return Colors.black12;
    }
  }
}
