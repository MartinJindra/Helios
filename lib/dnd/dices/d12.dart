import 'package:helios/dnd/dices/die.dart' show Die;

/// A D12 die.
class D12 extends Die {
  D12() : super(12);

  D12.mod(int modifier) : super.mod(12, modifier);
}
