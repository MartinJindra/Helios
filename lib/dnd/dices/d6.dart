import 'package:helios/dnd/dices/dice.dart';
import 'package:helios/dnd/dices/die.dart' show Die;

/// A D6 die.
class D6 extends Die {
  D6() : super(DiceSides.d6);

  D6.mod(int modifier) : super.mod(DiceSides.d6, modifier);
}
