import 'package:helios/dnd/dices/basedice.dart' show Dice;

/// A D4 die.
class D4 extends Dice {
  D4(int amount) : super(0, 0);

  D4.mod(int amount, int modifier) : super.mod(amount, 4, modifier);
}
