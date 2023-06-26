import 'package:helios/dnd/dices/dice.dart';
import 'package:helios/dnd/dices/die.dart' show Die;

/// A D4 die.
class D4 extends Die {
  D4() : super(DiceSides.d4);

  D4.mod(int modifier) : super.mod(DiceSides.d4, modifier);
}
