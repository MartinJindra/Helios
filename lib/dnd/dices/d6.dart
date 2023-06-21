import 'package:helios/dnd/dices/dice.dart' show Dice;

/// A D6 die.
class D6 extends Dice {
  D6(int amount) : super(amount, 6);

  D6.mod(int amount, int modifier) : super.mod(amount, 6, modifier);
}
