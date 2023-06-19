import 'package:helios/dnd/combat/damage.dart' show Damage;
import 'package:helios/dnd/properties/ability.dart' show Ability;
import 'package:helios/dnd/properties/range.dart' show Range;

/// A class representing an attack in DND.
class Attack {
  String uuid = '', name = '';
  late Range shortRange, longRange;
  int attack = 0;
  late Damage damage;
  bool displayed = false;
  late Ability ability;

  @override
  String toString() {
    StringBuffer str = StringBuffer();
    str.writeln('### $name');
    str.writeln('Short range: $shortRange');
    if (longRange.amount == 0) {
      str.writeln('Long range: $longRange');
    }
    str.writeln('Attack: $attack + AC');
    str.writeln('Damage: $damage');
    str.writeln('Ability: $ability');

    return str.toString();
  }
}
