import 'package:helios/dnd/dices/die.dart' show Die;

/// A D4 die.
class D4 extends Die {
  D4() : super(4);

  D4.mod(int modifier) : super.mod(4, modifier);
}
