import 'dart:core';

/// The appearance of a DnD character.
class Appearance {
  String height = '', weight = '', eyes = '', skin = '', hair = '';
  int age = 0;

  @override
  String toString() {
    StringBuffer str = StringBuffer();
    str.writeln('## Appearance');
    str.writeln('Age: $age');
    str.writeln('Height: $height');
    str.writeln('Weight: $weight');
    str.writeln('Eyes: $eyes');
    str.writeln('Skin: $skin');
    str.writeln('Hair: $hair');
    return str.toString();
  }
}
