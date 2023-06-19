import 'package:helios/dnd/unit/unit.dart';

/// An enum representing length in DND.
enum Length implements Unit {
  feet(1),
  inch(12),
  meter(0.3048),
  centimeter(30.48);

  const Length(this.val);

  final double val;
}
