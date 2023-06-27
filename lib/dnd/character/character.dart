import 'dart:collection' show HashMap;

import 'package:helios/dnd/character/appearance.dart' show Appearance;
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
  int level = 0, experience = 0;
  final Portrait characterPortrait = Portrait(), companionPortrait = Portrait();
  final List<Attack> attacks = List.empty(growable: true);
  Background background = Background('');
  Organization organization = Organization('');
  Inventory inventory = Inventory();
  final Map<String, String> notes = HashMap();
  Appearance appearance = Appearance();
  final Map<Ability, int> abilities = HashMap();
  bool allowFeats = false;
  bool allowMulticlassing = false;

  Character(this.name);

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
