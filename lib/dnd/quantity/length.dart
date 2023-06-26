import 'package:helios/dnd/quantity/unit.dart' show Unit;

/// An enum representing length in DND.
enum Length implements Unit {
  inch(.083),
  feet(1),
  centimeter(.0328084),
  meter(3.28084);

  const Length(this.value);

  final double value;
}
