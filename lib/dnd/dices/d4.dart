import 'package:helios/dnd/dices/dice.dart' show Dice;

/// A D4 die.
class D4 extends Dice {
  D4(int amount) : super(amount, 4);

  D4.mod(int amount, int modifier) : super.mod(amount, 4, modifier);
}
