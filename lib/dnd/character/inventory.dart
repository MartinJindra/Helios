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
    String header = '## Currencies';
    str.writeln(header);
    str.writeln('-' * header.length);
    for (Coin c in _currency.keys) {
      str.writeln('${_currency[c]} ${c.name}');
      str.writeln();
    }
    str.writeln();
    header = '## Equipment';
    str.writeln(header);
    str.writeln('-' * header.length);
    str.writeln(equipment);
    header = '## Treasure';
    str.writeln(header);
    str.writeln('-' * header.length);
    str.writeln(treasure);
    return str.toString();
  }
}
