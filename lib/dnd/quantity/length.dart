import 'package:helios/dnd/quantity/unit.dart' show Unit;

/// An enum representing length in DND.
enum Length implements Unit {
  feet(1),
  inch(.083),
  meter(3.28084),
  centimeter(.0328084);

  const Length(this.val);
  final double val;
}
