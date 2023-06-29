import 'package:helios/dnd/quantity/mass.dart' show Mass;
import 'package:helios/dnd/quantity/value.dart' show Value;

/// A class representing weight in DND.
final class Weight extends Value {
  const Weight(double amount, Mass unit) : super(amount, unit);
}
