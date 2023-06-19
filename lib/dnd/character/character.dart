import 'package:helios/dnd/character/background.dart';

class Character {
  String name = '', playerName = '', race = '', gender = '', className = '';
  late Background background = Background('');
  int level = 0, experience = 0;
  late List<int> characterPortrait;
  late List<int> companionPortrait;

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
    buffer.writeln();
    buffer.writeln('$background');
    buffer.writeln('Level: $level');
    buffer.writeln('Experience: $experience');
    return buffer.toString();
  }
}
