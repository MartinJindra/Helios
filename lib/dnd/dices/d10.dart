import 'package:helios/dnd/dices/dice.dart' show Dice;

/// A D10 die.
class D10 extends Dice {
  D10(int amount) : super(0, 0);

  D10.mod(int amount, int modifier) : super.mod(amount, 10, modifier);
}
