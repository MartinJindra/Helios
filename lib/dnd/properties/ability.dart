/// all main abilities.
enum Ability {
  none,
  strength,
  dexterity,
  constitution,
  intelligence,
  wisdom,
  charisma;

  static int getModifier(int amount) {
    return ((amount - 10) / 2).floor();
  }
}
