import 'package:helios/dnd/character/background.dart' show Background;
import 'package:helios/dnd/character/portrait.dart' show Portrait;

class Character {
  String name, playerName = '', race = '', gender = '', className = '';
  late Background background = Background('');
  int level = 0, experience = 0;
  final Portrait characterPortrait = Portrait(), companionPortrait = Portrait();

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
    buffer.writeln('$background');
    return buffer.toString();
  }
}
