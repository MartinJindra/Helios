import 'package:helios/dnd/quantity/length.dart' show Length;
import 'package:helios/dnd/quantity/value.dart' show Value;

/// A class representing range in DND.
final class Range extends Value {
  Range(double amount, Length unit) : super(amount, unit);

  /// Parse one or two ranges (short and long) from a string.
  /// The returned object is a map
  /// because a weapon can have on or multiple ranges.
  /// Keys for accessing are: `short` and `long`.
  static Map<String, Range> parse(String expr) {
    Range short, long;
    // if short and long range
    if (expr.contains('/')) {
      List<String> split = expr.split('/');
      short = Range(double.parse(split.first), Length.feet);
      long = Range(double.parse(split.last), Length.feet);
    } else {
      short = Range(double.parse(expr.split(' ').first), Length.feet);
      long = Range(0, Length.feet);
    }
    return {'short': short, 'long': long};
  }
}
