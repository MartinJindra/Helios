import 'package:helios/dnd/dices/die.dart' show Die;

/// A D0 die.
class D0 extends Die {
  D0() : super(0);

  D0.mod(int modifier) : super.mod(0, modifier);
}
