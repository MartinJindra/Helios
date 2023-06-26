import 'package:helios/dnd/dices/die.dart';

/// A mixer used for adding up multiple and different dice rolls.
class Mixer {
  final List<Die> dice = [];

  void add(Die die) {
    dice.add(die);
  }

  int roll() {
    int sum = 0;
    for (Die d in dice) {
      sum += d.roll;
    }
    return sum;
  }

  /// Parse a string into a dice.
  /// Examples:
  ///     `3d3 + 2`
  ///     `1d4`
  ///     `1    d    2`
  static Mixer parse(String expr) {
    expr = expr.replaceAll(' ', '');
    List<String> splits;
    int amount = 0, sides = 0, modifier = 0;
    // if modifier is present
    if (expr.contains('+')) {
      splits = expr.split('+');
      expr = splits[0];
      modifier = int.parse(splits[1]);
    } else if (expr.contains('-')) {
      splits = expr.split('-');
      expr = splits[0];
      modifier = int.parse(splits[1]);
      modifier *= -1;
    }
    // if only the expr is present
    if (expr.contains('d')) {
      splits = expr.split('d');
      amount = int.parse(splits[0]);
      sides = int.parse(splits[1]);
    }
    Mixer mix = Mixer();
    for (int i = 0; i < amount; i++) {
      mix.add(Die.mod(sides, modifier));
    }
    return mix;
  }

  @override
  String toString() {
    StringBuffer str = StringBuffer();
    for (Die d in dice) {
      str.write('$d+');
    }
    if (dice.isNotEmpty) {
      str = StringBuffer(str
          .toString()
          .replaceRange(str.toString().lastIndexOf('+'), null, ''));
    }
    return str.toString();
  }
}
