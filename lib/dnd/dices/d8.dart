import 'package:helios/dnd/dices/dice.dart';
import 'package:helios/dnd/dices/die.dart' show Die;

/// A D8 die.
class D8 extends Die {
  D8() : super(DiceSides.d8);

  D8.mod(int modifier) : super.mod(DiceSides.d8, modifier);
}
