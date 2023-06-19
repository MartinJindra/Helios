class Character {
  late String _name = '',
      _playerName = '',
      _race = '',
      _gender = '',
      _className = '',
      _background = '';
  late int _level = 0;
  late int _experience = 0;
  late List<int> _characterPortrait = List.empty();
  late List<int> _companionPortrait = List.empty();

  Character(this._name);

  set playerName(String value) {
    _playerName = value;
  }

  @override
  String toString() {
    String header = '# $_name ($_playerName):';
    final buffer = StringBuffer();
    buffer.writeln(header);
    buffer.writeln('-' * header.length);
    buffer.writeln();
    buffer.writeln('Class: $_className');
    buffer.writeln('Race: $_race');
    buffer.writeln('Gender: $_gender');
    buffer.writeln('Background: $_background');
    buffer.writeln('Level: $_level');
    buffer.writeln('Experience: $_experience');
    return buffer.toString();
  }
}
