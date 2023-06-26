import 'package:helios/dnd/dices/die.dart' show Die;

/// A D20 die.
class D20 extends Die {
  D20() : super(20);

  D20.mod(int modifier) : super.mod(20, modifier);
}
