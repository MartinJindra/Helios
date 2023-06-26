// A base class for dice.
import 'dart:math';

import 'package:helios/dnd/dices/dice.dart';

class Die {
  final DiceSides _type;
  late int _modifier, _roll;

  Die(this._type) {
    _modifier = 0;
    newRoll();
  }

  Die.mod(this._type, int modifier) {
    _modifier = modifier;
    newRoll();
  }

  int get sides => _type.sides;

  int get modifier => _modifier;
  int get roll => _roll;

  void newRoll() {
    if (_type.sides > 0) {
      _roll = _modifier + Random().nextInt(_type.sides) + 1;
    } else {
      _roll = _modifier + _type.sides;
    }
  }

  @override
  String toString() {
    // if empty die only modifier
    if (_type.sides == 0) {
      return '$_modifier';
    }

    String operator = '\u200B';
    if (_modifier >= 0) {
      operator = '+';
    }

    if (_modifier != 0) {
      return '1d${_type.sides}$operator$_modifier';
    } else {
      return '1d${_type.sides}';
    }
  }
}
