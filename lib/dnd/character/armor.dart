import 'package:helios/dnd/coins.dart' show Coin;
import 'package:helios/dnd/properties/money.dart' show Money;
import 'package:helios/dnd/properties/weight.dart' show Weight;
import 'package:helios/dnd/quantity/mass.dart' show Mass;

enum ArmorTable {
  padded(
      Armor('Padded', Money(5, Coin.gold), 11, false, Weight(8, Mass.pound))),
  leather(Armor(
      'Leather', Money(10, Coin.gold), 11, false, Weight(10, Mass.pound))),
  studdedLeather(Armor('Studded Leather', Money(45, Coin.gold), 12, false,
      Weight(13, Mass.pound))),
  hide(Armor('Hide', Money(10, Coin.gold), 12, false, Weight(12, Mass.pound))),
  chainShirt(Armor(
      'Chain Shirt', Money(50, Coin.gold), 13, false, Weight(20, Mass.pound))),
  scaleMail(Armor(
      'Scale Mail', Money(50, Coin.gold), 14, true, Weight(45, Mass.pound))),
  breastplate(Armor(
      'Breastplate', Money(400, Coin.gold), 14, false, Weight(40, Mass.pound))),
  halfPlate(Armor(
      'Half Plate', Money(750, Coin.gold), 15, true, Weight(40, Mass.pound))),
  ringMail(Armor(
      'Ring Mail', Money(30, Coin.gold), 14, true, Weight(40, Mass.pound))),
  chainMail(Armor(
      'Chain Mail', Money(75, Coin.gold), 16, true, Weight(55, Mass.pound))),
  splint(
      Armor('Splint', Money(200, Coin.gold), 17, true, Weight(60, Mass.pound))),
  plate(
      Armor('Plate', Money(1500, Coin.gold), 18, true, Weight(65, Mass.pound))),
  shield(
      Armor('Shield', Money(10, Coin.gold), 2, false, Weight(6, Mass.pound)));

  const ArmorTable(this.armor);
  final Armor armor;
}

final class Armor {
  final String name;
  final int ac;
  final Money cost;
  final bool stealthDisadvantage;
  final Weight weight;

  const Armor(
      this.name, this.cost, this.ac, this.stealthDisadvantage, this.weight);

  static empty() {
    return const Armor(
        '', Money(0, Coin.gold), 0, false, Weight(0, Mass.pound));
  }

  @override
  String toString() {
    return name;
  }
}
