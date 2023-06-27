enum LightArmor implements ArmorBase {
  padded,
  leather,
  studdedLeather,
}

enum MediumArmor implements ArmorBase {
  hide,
  chainShirt,
  scaleMail,
  breastplate,
  halfPlate,
}

enum HeavyArmor implements ArmorBase {
  ringMail,
  chainMail,
  splint,
  plate,
}

enum Shield implements ArmorBase { shield }

interface class ArmorBase {}

class Armor {
  late final ArmorBase armor;
  late final int cost, ac;
}
