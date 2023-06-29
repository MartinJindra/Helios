import 'package:helios/dnd/quantity/unit.dart' show Unit;

/// All coins for DnD.
enum Coin implements Unit {
  copper(0.1),
  silver(1),
  electrum(5),
  gold(10),
  platinum(100);

  const Coin(this.value);
  @override
  final double value;
}
