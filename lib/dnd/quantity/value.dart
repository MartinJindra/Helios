import 'package:helios/dnd/quantity/unit.dart' show Unit;

/// A super class to represent a value.
/// For example: 1 Meter, 20 Kilogram
abstract class Value {
  late double amount;
  late Unit unit;

  Value(this.amount, this.unit);

  setValues(double amount, Unit unit) {
    this.amount = amount;
    this.unit = unit;
  }

  /// Add up another unit.
  /// The sum will be in the unit
  /// of the object instance.
  add(Value second) =>
      setValues(round(amount + second.convert(unit).amount), unit);

  /// Subtract another unit.
  /// The subtraction will be in the unit
  /// of the object instance.
  subtract(Value second) =>
      setValues(round(amount - second.convert(unit).amount), unit);

  /// Multiply another unit.
  /// The multiplication will be in the unit
  /// of the object instance.
  ///
  void multiply(Value second) =>
      setValues(round(amount * second.convert(unit).amount), unit);

  /// Divide another unit.
  /// The division will be in the unit
  /// of the object instance.
  void divide(Value second) =>
      setValues(round(amount / second.convert(unit).amount), unit);

  /// Convert the value of one unit to another unit.
  Value convert(Unit to);

  /// round down a double value
  double round(double value) => double.parse(value.toStringAsFixed(2));

  @override
  String toString() {
    return '$amount ${unit.toString().split('.').last}';
  }
}
