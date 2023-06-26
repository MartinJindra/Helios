import 'package:helios/dnd/dices/dice.dart';
import 'package:helios/dnd/dices/die.dart' show Die;

/// A D20 die.
class D20 extends Die {
  D20() : super(DiceSides.d20);

  D20.mod(int modifier) : super.mod(DiceSides.d20, modifier);
}
