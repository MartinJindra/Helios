import 'package:helios/dnd/dices/dice.dart' show Dice;

/// A D0 die.
class D0 extends Dice {
  D0(int amount) : super(0, 0);

  D0.mod(int amount, int modifier) : super.mod(amount, 0, modifier);
}
