import 'package:helios/dnd/dices/dice.dart' show Dice;

/// A D100 die.
class D100 extends Dice {
  D100(int amount) : super(amount, 100);

  D100.mod(int amount, int modifier) : super.mod(amount, 100, modifier);
}
