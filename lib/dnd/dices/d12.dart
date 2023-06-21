import 'package:helios/dnd/dices/dice.dart' show Dice;

/// A D12 die.
class D12 extends Dice {
  D12(int amount) : super(amount, 12);

  D12.mod(int amount, int modifier) : super.mod(amount, 12, modifier);
}
