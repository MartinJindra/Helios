import 'package:helios/dnd/dices/dice.dart' show Dice;

/// A D8 die.
class D8 extends Dice {
  D8(int amount) : super(amount, 8);

  D8.mod(int amount, int modifier) : super.mod(amount, 8, modifier);
}
