import 'package:helios/dnd/coins.dart';
import 'package:helios/dnd/properties/money.dart';
import 'package:helios/dnd/properties/weight.dart';
import 'package:helios/dnd/quantity/mass.dart';

enum LightArmor implements ArmorBase {
  padded(
      Armor('Padded', 11, Money(5, Coin.gold), false, Weight(8, Mass.pound)));
  // leather('Leather'),
  // studdedLeather('Studded Leather');

  const LightArmor(this.armor);
  final Armor armor;
}

enum MediumArmor implements ArmorBase {
  hide('Hide'),
  chainShirt('Chain Shirt'),
  scaleMail('Scale Mail'),
  breastplate('Breastplate'),
  halfPlate('Half Plate');

  const MediumArmor(this.name);
  final String name;
}

enum HeavyArmor implements ArmorBase {
  ringMail('Ring Mail'),
  chainMail('Chain Mail'),
  splint('Splint'),
  plate('Plate');

  const HeavyArmor(this.name);
  final String name;
}

enum Shield implements ArmorBase {
  shield('Shield');

  const Shield(this.name);
  final String name;
}

interface class ArmorBase {}

class Armor {
  final String armor;
  final int ac;
  final Money cost;
  final bool stealthDisadvantage;
  final Weight weight;

  const Armor(
      this.armor, this.ac, this.cost, this.stealthDisadvantage, this.weight);
}
