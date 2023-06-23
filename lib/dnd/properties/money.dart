import 'package:helios/dnd/coins.dart';
import 'package:helios/dnd/quantity/unit.dart';
import 'package:helios/dnd/quantity/value.dart';

/// Monnnneeeeeyyyy.
class Money extends Value {
  Money(double amount, Coin coin) : super(amount, coin);

  /// Convert the value of one unit to another unit.
  @override
  Money convert(Unit to) {
    Coin c = to as Coin;
    double d = super.amount * (super.unit as Coin).value;
    return Money(round(d / c.value), c);
  }
}
