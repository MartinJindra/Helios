import 'package:helios/dnd/dices/dice.dart';
import 'package:helios/dnd/dices/die.dart' show Die;

/// A D100 die.
class D100 extends Die {
  D100() : super(DiceSides.d100);

  D100.mod(int modifier) : super.mod(DiceSides.d100, modifier);
}
