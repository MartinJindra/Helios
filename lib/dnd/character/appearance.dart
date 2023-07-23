import 'dart:core';

/// The appearance of a DnD character.
class Appearance {
  String height = '', weight = '', eyes = '', skin = '', hair = '';
  int age = 0;

  @override
  String toString() {
    StringBuffer str = StringBuffer();
    const String header = '## Appearance';
    str.writeln(header);
    str.writeln('-' * header.length);
    str.writeln('Age: $age');
    str.writeln();
    str.writeln('Height: $height');
    str.writeln();
    str.writeln('Weight: $weight');
    str.writeln();
    str.writeln('Eyes: $eyes');
    str.writeln();
    str.writeln('Skin: $skin');
    str.writeln();
    str.writeln('Hair: $hair');
    str.writeln();
    return str.toString();
  }
}
