// A base class for dice.
import 'dart:math';

import 'package:helios/dnd/dices/dice.dart';

class Die {
  final DiceSides type;
  int _modifier = 0, _roll = 0;

  Die(this.type) {
    newRoll();
  }

  Die.mod(this.type, int modifier) {
    _modifier = modifier;
    newRoll();
  }

  int get sides => type.sides;
  int get modifier => _modifier;
  int get roll => _roll;

  void newRoll() {
    if (type.sides > 0) {
      _roll = _modifier + Random().nextInt(type.sides) + 1;
    } else {
      _roll = _modifier + type.sides;
    }
  }

  @override
  String toString() {
    // if empty die only modifier
    if (type.sides == 0) {
      return '$_modifier';
    }

    String operator = '\u200B';
    if (_modifier >= 0) {
      operator = '+';
    }

    if (_modifier != 0) {
      return '1d${type.sides}$operator$_modifier';
    } else {
      return '1d${type.sides}';
    }
  }
}
