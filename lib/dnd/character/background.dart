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
    str.writeln('## $roll Background');
    str.writeln('Trinket: $trinket');
    str.writeln('Traits: $traits');
    str.writeln('Ideals: $ideals');
    str.writeln('Bonds: $bonds');
    str.writeln('Flaws: $flaws');
    str.writeln('\n$feature');
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
    str.writeln(description);
    return str.toString();
  }
}
