import 'package:helios/dnd/dices/die.dart' show Die;

/// A D10 die.
class D10 extends Die {
  D10() : super(10);

  D10.mod(int modifier) : super.mod(10, modifier);
}
