import 'package:helios/dnd/dices/die.dart' show Die;

/// A D8 die.
class D8 extends Die {
  D8() : super(8);

  D8.mod(int modifier) : super.mod(8, modifier);
}
