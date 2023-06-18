import 'package:helios/dnd/dices/basedice.dart' show Dice;

/// A D8 die.
class D8 extends Dice {
  D8(int amount) : super(0, 0);

  D8.mod(int amount, int modifier) : super.mod(amount, 8, modifier);
}
