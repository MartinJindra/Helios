interface class BaseUnit {}

/// A super class for units.
abstract class Unit {
  late double _amount;

  late BaseUnit _unit;

  Unit(double amount, BaseUnit unit) {
    setValues(amount, unit);
  }

  setValues(double amount, var unit) {
    _amount = amount;
    _unit = unit;
  }

  double getAmount() {
    return _amount;
  }

  BaseUnit getUnit() {
    return _unit;
  }

  /// Add up another unit.
  /// The sum will be in the unit
  /// of the object instance.
  add(Unit second) => setValues(
      (getAmount() + second.convert(getUnit()).getAmount()).roundToDouble(),
      getUnit());

  /// Subtract another unit.
  /// The subtraction will be in the unit
  /// of the object instance.
  subtract(Unit second) => setValues(
      (getAmount() - second.convert(getUnit()).getAmount()).roundToDouble(),
      getUnit());

  /// Multiply another unit.
  /// The multiplication will be in the unit
  /// of the object instance.
  ///
  void multiply(Unit second) => setValues(
      (getAmount() * second.convert(getUnit()).getAmount()), getUnit());

  /// Divide another unit.
  /// The division will be in the unit
  /// of the object instance.
  void divide(Unit second) => setValues(
      (getAmount() / second.convert(getUnit()).getAmount()), getUnit());

  /// Convert the value of one unit to another unit.
  Unit convert(BaseUnit to);

  @override
  String toString() {
    return '$_amount $_unit';
  }
}
