// A base class for dice.
import 'dart:math';

class Die {
  late int _sides, _modifier, _roll;

  Die(int sides) {
    _sides = sides;
    _modifier = 0;
    newRoll();
  }

  Die.mod(int sides, int modifier) {
    _sides = sides;
    _modifier = modifier;
    newRoll();
  }

  int get sides => _sides;
  int get modifier => _modifier;
  int get roll => _roll;

  void newRoll() {
    if (_sides > 0) {
      _roll = _modifier + Random().nextInt(_sides) + 1;
    } else {
      _roll = _modifier + _sides;
    }
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

    if (_modifier != 0) {
      return '1d$_sides$operator$_modifier';
    } else {
      return '1d$_sides';
    }
  }
}
