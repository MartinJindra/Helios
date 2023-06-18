// A base class for dice.
import 'package:helios/dnd/roll/roll.dart' show Roll;

class Dice {
  late final int _amount, _sides, _modifier;
  late final Roll _roll;

  Dice(int amount, int sides) {
    Dice.mod(amount, sides, 0);
  }

  Dice.mod(int amount, int sides, int modifier) {
    _amount = amount;
    _sides = sides;
    _modifier = modifier;
    _roll = Roll.create(_amount, _sides, _modifier);
  }

  int get amount => _amount;

  int get sides => _sides;

  int get modifier => _modifier;

  /// Roll a die.
  Roll roll() {
    return Roll.create(_amount, _sides, _modifier);
  }

  /// Get the total sum of multiple rolls.
  int sum() {
    return _roll.total;
  }

  @override
  String toString() {
    // if empty die only modifier
    if (_sides == 0) {
      return '$_modifier';
    }

    String operator = '\u200B';
    if (_modifier >= 0) {
      operator = '+';
    }

    StringBuffer str = StringBuffer();
    if (_roll.order.length == 1) {
      if (_modifier != 0) {
        str.write('${_amount}d$_sides$operator$_modifier');
      } else {
        str.write('${_amount}d$_sides');
      }
    } else {
      for (int i = 0; i < _roll.order.length; i++) {
        if (_modifier != 0) {
          str.write('${_amount}d$_sides$operator$modifier');
        } else {
          str.write('${_amount}d$_sides');
        }
      }
      String tmp = str.toString();
      tmp.replaceRange(tmp.lastIndexOf('+'), null, '');
      return tmp;
    }
    return str.toString();
  }

  /// Parse a string into a dice.
  /// Examples:
  ///     `3d3 + 2`
  ///     `1d4`
  ///     `1    d    2`
  static Dice parse(String dice) {
    dice = dice.replaceAll(' ', '');
    List<String> splits;
    int amount = 0, sides = 0, modifier = 0;
    // if modifier is present
    if (dice.contains('+')) {
      splits = dice.split('+');
      dice = splits[0];
      modifier = int.parse(splits[1]);
    } else if (dice.contains('-')) {
      splits = dice.split('-');
      dice = splits[0];
      modifier = int.parse(splits[1]);
      modifier *= -1;
    }
    // if only the dice is present
    if (dice.contains('d')) {
      splits = dice.split('d');
      amount = int.parse(splits[0]);
      sides = int.parse(splits[1]);
    }
    return Dice.mod(amount, sides, modifier);
  }

// TODO add an optional modifier for dices
}
