import 'package:helios/dnd/dices/d0.dart' show D0;
import 'package:helios/dnd/dices/die.dart';
import 'package:helios/dnd/dices/mixer.dart' show Mixer;
import 'package:helios/dnd/properties/damagetype.dart' show DamageType;

/// Class representing damage.
class Damage {
  Mixer dice = Mixer();
  DamageType type;

  Damage(this.dice, this.type);

  Damage.die(Die die, this.type) {
    dice.add(die);
  }

  Damage.mod(int modifier, this.type) {
    dice.add(D0.mod(modifier));
  }

  /// Parses an expression for a Damage object.
  /// A die (and optional damage type) is required.
  static Damage parse(String expression) {
    List<String> stringSplit = expression.trim().split(" ");

    if (stringSplit.length == 1) {
      stringSplit[0] = stringSplit[0].replaceAll("+", "");
      return Damage.mod(int.parse(stringSplit[0]), DamageType.none);
    }
    DamageType type;
    if (stringSplit[1] == '') {
      type = DamageType.none;
    } else {
      type = DamageType.values
          .firstWhere((DamageType e) => (e.name == stringSplit[1]));
    }
    return Damage(Mixer.parse(stringSplit[0]), type);
  }

  @override
  String toString() {
    return '$dice ${type == DamageType.none ? '' : type.name}';
  }
}
