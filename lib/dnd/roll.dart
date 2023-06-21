import 'dart:math' show Random;

/// Class representing a die roll.
class Roll {
  late final List<int> _order;

  late final int _total;

  /// Generate a roll.
  /// Runs loops over amount and generates
  /// a random number from 0 (exclusive) and dice (inclusive).
  /// Plus modifier.
  Roll(int amount, int dice, int modifier) {
    _order = List.filled(amount, 0);
    int total = modifier;
    for (int i = 0; i < amount; i++) {
      // Generate die roll between 1 and [dice]
      _order[i] = Random().nextInt(dice) + 1;
      total += _order[i];
    }
    _total = total;
  }

  static Roll create(int amount, int dice, int modifier) {
    return Roll(amount, dice, modifier);
  }

  /// Get the total sum of the roll.
  int get sum => _total;

  /// Get the order of the dice rolls.
  List<int> get order => _order;

  @override
  String toString() {
    return '$_total';
  }
}
