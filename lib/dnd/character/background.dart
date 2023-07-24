/// The backstory of a DnD character.
class Background {
  String roll;
  String story = '',
      trinket = '',
      traits = '',
      ideals = '',
      bonds = '',
      flaws = '';
  Feature feature = Feature('', '');

  Background(this.roll);

  @override
  String toString() {
    StringBuffer str = StringBuffer();
    String header = '## $roll Background';
    str.writeln(header);
    str.writeln('-' * header.length);
    str.writeln();
    str.writeln('**Trinket:** $trinket');
    str.writeln();
    str.writeln('**Traits:** $traits');
    str.writeln();
    str.writeln('**Ideals:** $ideals');
    str.writeln();
    str.writeln('**Bonds:** $bonds');
    str.writeln();
    str.writeln('**Flaws:** $flaws');
    str.writeln();
    str.writeln('$feature');
    str.writeln();
    return str.toString();
  }
}

/// A background feature of a character.
class Feature {
  late String name, description;

  Feature(this.name, this.description);

  @override
  String toString() {
    StringBuffer str = StringBuffer();
    str.writeln('### $name');
    str.writeln(description.trim());
    return str.toString();
  }
}
