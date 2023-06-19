import 'package:helios/dnd/unit/length.dart';
import 'package:helios/dnd/unit/unit.dart';
import 'package:helios/dnd/unit/value.dart';

/// A class representing range in DND.
class Range extends Value {
  Range(double amount, Length unit) : super(amount, unit);

  /// Convert the value of one unit to another unit.
  @override
  Range convert(Unit to) {
    Length l = to as Length;
    double d = super.amount / (super.unit as Length).val;
    return Range((d * l.val).roundToDouble(), l);
  }
}
