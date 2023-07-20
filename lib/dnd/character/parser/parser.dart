import 'package:helios/dnd/character/background.dart' show Feature;
import 'package:helios/dnd/character/character.dart' show Character;
import 'package:helios/dnd/coins.dart' show Coin;
import 'package:helios/dnd/combat/attack.dart' show Attack;
import 'package:helios/dnd/combat/damage.dart' show Damage;
import 'package:helios/dnd/dices/d0.dart' show D0;
import 'package:helios/dnd/organization.dart' show Organization;
import 'package:helios/dnd/properties/ability.dart' show Ability;
import 'package:helios/dnd/properties/damagetype.dart' show DamageType;
import 'package:helios/dnd/properties/range.dart' show Range;
import 'package:helios/util/file.dart' as util;
import 'package:helios/util/xml.dart' show XMLGetter;
import 'package:xml/xml.dart'
    show XmlAttribute, XmlDocument, XmlName, XmlNode, XmlTagException;

class Parser {
  late String _path;
  Character character = Character('');
  late XMLGetter xmlGetter;
  late XmlDocument _document;

  Parser.empty() {
    _path = '';
  }

  Parser(this._path) {
    try {
      if (_path.isNotEmpty) {
        _document = XmlDocument.parse(util.readString(_path));
        xmlGetter = XMLGetter(_document);
      }
    } on XmlTagException {
      throw XmlTagException('Error while parsing $_path');
    }
  }

  void parse() {
    try {
      _processInformationElement();
      _processDisplayInformationElement();
      _processBuildElement();
    } on XmlTagException {
      throw XmlTagException('Error while parsing $_path');
    }
  }

  /// Process the 'display-information' tag.
  void _processInformationElement() {
    character.group = xmlGetter.txt('character/information/group');
  }

  /// Process the 'display-information' tag.
  void _processDisplayInformationElement() {
    String expr = 'character/display-properties';
    // race
    character.race = xmlGetter.txt('$expr/race');
    // class
    character.className = xmlGetter.txt('$expr/class');
    // background roll
    character.background.roll = xmlGetter.txt('$expr/background');
    // level
    character.level = xmlGetter.num('$expr/level');
    // portrait
    character.characterPortrait
        .setBase64(xmlGetter.txt('$expr/portrait/base64'));
    character.companionPortrait.setPath(xmlGetter.txt('$expr/portrait/local'));
  }

  /// Process the 'build' tag.
  void _processBuildElement() {
    _processBasicInformation();
    _processAttacks();
    _processBackstory();
    _processOrganization();
    _processAdditionalFeature();
    _processInventory();
    _processNotes();
    _processQuest();
    _processAppearanceElement();
    _processAbilitiesElement();
    _processElements();
  }

  /// Process the basic information of a character.
  void _processBasicInformation() {
    String expr = 'character/build/input';
    // name
    character.name = xmlGetter.txt('$expr/name');
    // gender
    character.gender = xmlGetter.txt('$expr/gender');
    // player name
    character.playerName = xmlGetter.txt('$expr/player-name');
    // experience
    character.experience = xmlGetter.num('$expr/experience');
  }

  /// Process the attacks of a character.
  void _processAttacks() {
    // attacks
    Attack tmpAttack;
    String expr = 'character/build/input/attacks',
        uuid = '',
        name = '',
        attack = '';
    Map<String, Range> ranges = {};
    Damage damage = Damage.die(D0(), DamageType.none);
    Ability ability = Ability.none;
    for (XmlNode attackElement in xmlGetter.elements(expr)) {
      XmlAttribute(XmlName('uuid'), '');
      name = XMLGetter.attrValTxtWithElement(attackElement, 'name');
      ranges =
          Range.parse(XMLGetter.attrValTxtWithElement(attackElement, 'range'));
      attack = XMLGetter.attrValTxtWithElement(attackElement, 'attack');
      damage = Damage.parse(
          XMLGetter.attrValTxtWithElement(attackElement, 'damage'));
      ability = Ability.values.byName(
          XMLGetter.attrValTxtWithElement(attackElement, 'ability')
              .toLowerCase());
      tmpAttack = Attack(
          uuid, name, ranges['short']!, ranges['long']!, damage, ability);
      tmpAttack.setAttack(attack);
      character.attacks.add(tmpAttack);
    }
  }

  /// Process the backstory.
  void _processBackstory() {
    // backstory
    String expr = 'character/build/input';
    character.background.story = xmlGetter.txt('$expr/backstory');
    character.background.trinket = xmlGetter.txt('$expr/background-trinket');
    character.background.traits = xmlGetter.txt('$expr/background-traits');
    character.background.ideals = xmlGetter.txt('$expr/background-ideals');
    character.background.bonds = xmlGetter.txt('$expr/background-bonds');
    character.background.flaws = xmlGetter.txt('$expr/background-flaws');
    character.background.feature = Feature(
        xmlGetter.attrValTxt('$expr/background/feature', 'name'),
        xmlGetter.txt('$expr/background/feature/description'));
  }

  /// Process which organization the character is aligned with.
  void _processOrganization() {
    // organization
    String expr = 'character/build/input/organization';
    character.organization = Organization(xmlGetter.txt('$expr/name'));
    character.organization.setSymbol(xmlGetter.txt('$expr/symbol'));
    character.organization.allies = xmlGetter.txt('$expr/allies');
  }

  /// Process the additional Features.
  void _processAdditionalFeature() {
    // additional feature
    character.additionalFeatures =
        xmlGetter.txt('character/build/input/organization/additional-features');
  }

  /// Process the items of the character (i.e coins, ...).
  void _processInventory() {
    // currency, inventory and treasure
    String expr = 'character/build/input/currency';
    for (Coin c in Coin.values) {
      character.inventory.setCoin(c, xmlGetter.num('$expr/${c.name}'));
    }
    character.inventory.equipment = xmlGetter.txt('$expr/equipment');
    character.inventory.treasure = xmlGetter.txt('$expr/treasure');
  }

  /// Process the notes of the character sheets.
  void _processNotes() {
    // notes
    for (XmlNode note in xmlGetter.elements('character/build/input/notes')) {
      character.notes.putIfAbsent(
          XMLGetter.attrValTxtWithElement(note, 'column'),
          () => XMLGetter.val(note));
    }
  }

  /// Process the quest.
  void _processQuest() {
    character.quest = xmlGetter.txt('character/build/input/quest');
  }

  /// Process the 'appearance' tag.
  void _processAppearanceElement() {
    String expr = 'character/build/input/appearance';
    character.appearance.age = xmlGetter.num('$expr/age');
    character.appearance.height = xmlGetter.txt('$expr/height');
    character.appearance.weight = xmlGetter.txt('$expr/weight');
    character.appearance.eyes = xmlGetter.txt('$expr/eyes');
    character.appearance.skin = xmlGetter.txt('$expr/skin');
    character.appearance.hair = xmlGetter.txt('$expr/hair');
  }

  /// Process the abilities of the character.
  void _processAbilitiesElement() {
    for (Ability ability in Ability.values) {
      character.abilities.putIfAbsent(ability,
          () => xmlGetter.num('character/build/input/${ability.name}'));
    }
  }

  void _processElements() {
    //   XmlElement elementsElement = getElement(_buildElement, 'elements');
    //   String type, name;
    //   for (XmlElement child in elementsElement.childElements) {
    //     type = getAttributeValueText(child, 'type');
    //     // Type="option"
    //     if (type == Types.option.text) {
    //       name = getAttributeValueText(child, 'name');
    //       if (name == Name.feats.text) {
    //         character.allowFeats = true;
    //       }
    //       if (name == Name.multiclassing.text) {
    //         character.allowMulticlassing = true;
    //       }
    //     }
    //     // Type="Armor"
    //     else if (type == Types.armor.text) {
    //       String armorString = getAttributeValueText(child, 'name');
    //       ArmorTable armorType = ArmorTable.values.firstWhere(
    //           (ArmorTable element) => element.armor.name == armorString);
    //       character.armor = armorType.armor;
    //     } else if (type == Types.level.text &&
    //         getAttributeValueText(child, 'name') == '1') {
    //       getAttributeValueText(child, 'rndhp').split(',').forEach((element) {
    //         character.hp.add(int.parse(element));
    //       });
    //     }
    //   }
  }
}
