import 'dart:collection' show HashMap;

import 'package:helios/dnd/character/appearance.dart' show Appearance;
import 'package:helios/dnd/character/armor.dart';
import 'package:helios/dnd/character/background.dart' show Background;
import 'package:helios/dnd/character/inventory.dart' show Inventory;
import 'package:helios/dnd/character/portrait.dart' show Portrait;
import 'package:helios/dnd/combat/attack.dart' show Attack;
import 'package:helios/dnd/organization.dart' show Organization;
import 'package:helios/dnd/properties/ability.dart' show Ability;

class Character {
  String name,
      playerName = '',
      race = '',
      gender = '',
      className = '',
      additionalFeatures = '',
      quest = '',
      group = '';
  final List<int> hp = List.empty(growable: true);
  final List<Attack> attacks = List.empty(growable: true);
  final Map<String, String> notes = HashMap();
  final Map<Ability, int> abilities = HashMap();
  Appearance appearance = Appearance();
  Armor armor = Armor.empty();
  Background background = Background('');
  Inventory inventory = Inventory();
  Organization organization = Organization('');
  final Portrait characterPortrait = Portrait(), companionPortrait = Portrait();
  int level = 0, experience = 0;
  bool allowFeats = false;
  bool allowMulticlassing = false;

  Character(this.name);

  /// Calculate the current Max HP
  int getMaxHP() {
    int sum = 0,
        mod = Ability.getModifier(abilities[Ability.constitution] ?? 0);
    for (int i = 0; i < level; i++) {
      sum += hp[i] + mod;
    }
    return sum;
  }

  @override
  String toString() {
    String header = '# $name ($playerName):';
    final buffer = StringBuffer();
    buffer.writeln(header);
    buffer.writeln('-' * header.length);
    buffer.writeln('Class: $className');
    buffer.writeln('Race: $race');
    buffer.writeln('Gender: $gender');
    buffer.writeln('Level: $level');
    buffer.writeln('Experience: $experience');
    buffer.writeln('Max HP: ${getMaxHP()}');
    buffer.writeln('Armor: $armor');
    buffer.writeln();
    header = '## Attacks:';
    buffer.writeln(header);
    buffer.writeln('-' * header.length);
    buffer.writeln();
    for (Attack attack in attacks) {
      buffer.writeln(attack);
    }
    buffer.writeln(background);
    buffer.writeln(organization);
    buffer.writeln(inventory);
    buffer.writeln('## Notes');
    for (String note in notes.values) {
      if (note.isNotEmpty) {
        buffer.writeln(note.trim());
      }
    }
    buffer.writeln('## Quests');
    buffer.writeln(quest);
    buffer.writeln(appearance);
    buffer.writeln('## Abilities');
    for (Ability ability in Ability.values) {
      if (ability != Ability.none) {
        buffer.writeln('${ability.name}: ${abilities[ability]}');
      }
    }
    return buffer.toString();
  }
}
