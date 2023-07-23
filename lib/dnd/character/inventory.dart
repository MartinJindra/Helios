import 'dart:collection' show HashMap;

import 'package:helios/dnd/coins.dart' show Coin;

class Inventory {
  final Map<Coin, int> _currency = HashMap();
  String equipment = '', treasure = '';

  Inventory() {
    for (Coin c in Coin.values) {
      _currency.putIfAbsent(c, () => 0);
    }
  }

  void setCoin(Coin c, int value) {
    _currency.update(c, (old) => (value));
  }

  @override
  String toString() {
    StringBuffer str = StringBuffer();
    str.writeln('## Currencies');
    for (Coin c in _currency.keys) {
      str.writeln('${_currency[c]} ${c.name}');
      str.writeln();
    }
    str.writeln();
    str.writeln('## Equipment');
    str.writeln(equipment);
    str.writeln('## Treasure');
    str.writeln(treasure);
    return str.toString();
  }
}
