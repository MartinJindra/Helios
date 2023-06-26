import 'package:helios/dnd/dices/dice.dart';
import 'package:helios/dnd/dices/die.dart' show Die;

/// A D10 die.
class D10 extends Die {
  D10() : super(DiceSides.d10);

  D10.mod(int modifier) : super.mod(DiceSides.d10, modifier);
}
