import 'package:helios/dnd/quantity/unit.dart' show Unit;

/// A super class to represent a value.
/// For example: 1 Meter, 20 Kilogram
base class Value {
  final double amount;
  final Unit unit;

  const Value(this.amount, this.unit);

  /// Add up another unit.
  /// The sum will be in the unit
  /// of the object instance.
  static Value add(Value first, Value second) {
    return Value(
        round(first.amount + convert(second, first.unit).amount), first.unit);
  }

  /// Subtract another unit.
  /// The subtraction will be in the unit
  /// of the object instance.
  static Value subtract(Value first, Value second) {
    return Value(
        round(first.amount - convert(second, first.unit).amount), first.unit);
  }

  /// Multiply another unit.
  /// The multiplication will be in the unit
  /// of the object instance.
  ///
  static Value multiply(Value first, Value second) {
    return Value(
        round(first.amount * convert(second, first.unit).amount), first.unit);
  }

  /// Divide another unit.
  /// The division will be in the unit
  /// of the object instance.
  static Value divide(Value first, Value second) {
    return Value(
        round(first.amount / convert(second, first.unit).amount), first.unit);
  }

  /// round down a double value
  static double round(double value) => double.parse(value.toStringAsFixed(2));

  /// Convert the value of one unit to another unit.
  static Value convert(Value from, Unit to) {
    double d = from.amount * from.unit.value;
    return Value(round(d / to.value), to);
  }

  @override
  String toString() {
    return '${amount.ceil()} ${unit.toString().split('.').last}';
  }
}
