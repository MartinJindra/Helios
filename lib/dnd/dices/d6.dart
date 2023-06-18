import 'package:helios/dnd/dices/basedice.dart' show Dice;

/// A D6 die.
class D6 extends Dice {
  D6(int amount) : super(0, 0);

  D6.mod(int amount, int modifier) : super.mod(amount, 6, modifier);
}
