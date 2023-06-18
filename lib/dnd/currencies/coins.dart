import 'package:helios/dnd/unit.dart' show BaseUnit;

/// All coins for DnD.

enum Coin implements BaseUnit {
  copper(10),
  silver(1),
  electrum(0.2),
  gold(0.1),
  platinum(0.01);

  const Coin(this.value);

  final double value;
}
