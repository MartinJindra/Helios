import 'package:helios/dnd/combat/damage.dart' show Damage;
import 'package:helios/dnd/properties/ability.dart' show Ability;
import 'package:helios/dnd/properties/range.dart' show Range;

/// A class representing an attack in DND.
class Attack {
  String uuid = '', name = '';
  late Range shortRange, longRange;
  int _attack = 0;
  late Damage damage;
  bool displayed = false;
  late Ability ability;

  /// set the attack bonus via an expression.
  void setAttack(String expr) {
    List<String> split = expr.split(' ');
    _attack = int.parse(split[0]);
  }

  get attack => _attack;

  @override
  String toString() {
    StringBuffer str = StringBuffer();
    str.writeln('### $name');
    str.writeln('Short range: $shortRange');
    if (longRange.amount != 0.0) {
      str.writeln('Long range: $longRange');
    }
    str.writeln('Attack: $attack + AC');
    str.writeln('Damage: $damage');
    str.writeln('Ability: ${ability.name}');

    return str.toString();
  }
}
