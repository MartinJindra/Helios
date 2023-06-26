import 'package:helios/dnd/dices/die.dart' show Die;

/// A D100 die.
class D100 extends Die {
  D100() : super(100);

  D100.mod(int modifier) : super.mod(100, modifier);
}
