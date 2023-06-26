import 'package:helios/dnd/dices/dice.dart';
import 'package:helios/dnd/dices/die.dart';
import 'package:helios/util/strings.dart';

/// A mixer used for adding up multiple and different dice rolls.
class Mixer {
  final Map<DiceSides, List<Die>> dice = {};

  /// Get a DiceSides Object from an integer.
  static DiceSides getDiceSides(int sides) {
    return DiceSides.values.firstWhere((element) => element.sides == sides);
  }

  /// Get a Die Object from an integer.
  static Die getDiceObject(int sides, int modifier) {
    return Die.mod(getDiceSides(sides), modifier);
  }

  /// Update a list of dice.
  /// If not present new list is added.
  void add(Die die) {
    DiceSides sides = getDiceSides(die.sides);
    if (dice.containsKey(sides)) {
      List<Die>? list = dice[sides];
      list!.add(die);
      dice[sides] = list;
    } else {
      dice[sides] = [die];
    }
  }

  int roll() {
    int sum = 0;
    for (DiceSides side in DiceSides.values) {
      for (Die die in dice[side]!) {
        sum += die.roll;
      }
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
      mix.add(getDiceObject(sides, modifier));
    }
    return mix;
  }

  @override
  String toString() {
    StringBuffer str = StringBuffer();
    for (List<Die> dice in dice.values) {
      str.write('${dice.length}d${dice.first.sides}+');
    }
    if (dice.isNotEmpty) {
      return removeLast(str.toString(), '+');
    }
    return str.toString();
  }
}
