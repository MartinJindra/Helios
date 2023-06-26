import 'package:helios/dnd/dices/dice.dart';
import 'package:helios/dnd/dices/die.dart' show Die;

/// A D12 die.
class D12 extends Die {
  D12() : super(DiceSides.d12);

  D12.mod(int modifier) : super.mod(DiceSides.d12, modifier);
}
