import 'package:helios/dnd/quantity/unit.dart';

/// An enum representing mass in DND.
enum Mass implements Unit {
  pound(1),
  kilogram(2.2046);

  const Mass(this.value);
  @override
  final double value;
}
