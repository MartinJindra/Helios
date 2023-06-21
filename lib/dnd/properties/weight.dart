import 'package:helios/dnd/quantity/mass.dart' show Mass;
import 'package:helios/dnd/quantity/unit.dart' show Unit;
import 'package:helios/dnd/quantity/value.dart' show Value;

/// A class representing weight in DND.
class Weight extends Value {
  Weight(double amount, Mass unit) : super(amount, unit);

  /// Convert the value of one unit to another unit.
  @override
  Weight convert(Unit to) {
    Mass m = to as Mass;
    double d = super.amount * (super.unit as Mass).val;
    return Weight((d / m.val), m);
  }
}
