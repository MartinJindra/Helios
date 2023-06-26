import 'package:helios/dnd/dices/dice.dart';
import 'package:helios/dnd/dices/die.dart' show Die;

/// A D0 die.
class D0 extends Die {
  D0() : super(DiceSides.d0);

  D0.mod(int modifier) : super.mod(DiceSides.d0, modifier);
}
