import 'package:helios/dnd/dices/die.dart' show Die;

/// A D6 die.
class D6 extends Die {
  D6() : super(6);

  D6.mod(int modifier) : super.mod(6, modifier);
}
