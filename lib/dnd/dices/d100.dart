import 'package:helios/dnd/dices/basedice.dart' show Dice;

/// A D100 die.
class D100 extends Dice {
  D100(int amount) : super(0, 0);

  D100.mod(int amount, int modifier) : super.mod(amount, 100, modifier);
}
