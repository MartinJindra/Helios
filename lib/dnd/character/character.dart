import 'package:helios/dnd/character/background.dart' show Background;
import 'package:helios/dnd/character/inventory.dart' show Inventory;
import 'package:helios/dnd/character/portrait.dart' show Portrait;
import 'package:helios/dnd/combat/attack.dart' show Attack;
import 'package:helios/dnd/organization.dart' show Organization;

class Character {
  String name, playerName = '', race = '', gender = '', className = '';
  int level = 0, experience = 0;
  final Portrait characterPortrait = Portrait(), companionPortrait = Portrait();
  final List<Attack> attacks = List.empty(growable: true);
  Background background = Background('');
  Organization organization = Organization('');
  String additionalFeatures = '';
  Inventory inventory = Inventory();

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
    buffer.writeln(inventory);
    return buffer.toString();
  }
}
