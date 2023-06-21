import 'package:helios/dnd/character/background.dart' show Feature;
import 'package:helios/dnd/character/character.dart' show Character;
import 'package:helios/dnd/coins.dart';
import 'package:helios/dnd/combat/attack.dart' show Attack;
import 'package:helios/dnd/combat/damage.dart' show Damage;
import 'package:helios/dnd/organization.dart';
import 'package:helios/dnd/properties/ability.dart' show Ability;
import 'package:helios/dnd/properties/range.dart' show Range;
import 'package:helios/util/file.dart' as util;
import 'package:helios/util/xml.dart'
    show
        getAttributeValueText,
        getElement,
        getElementValueNumber,
        getElementValueText,
        getRootElement,
        getText;
import 'package:xml/xml.dart' show XmlDocument, XmlElement;

class Parser {
  late Character character = Character('');
  late final XmlDocument _document;
  late final XmlElement _characterElement,
      _informationElement,
      _displayPropertiesElement,
      _buildElement;

  Parser.empty();

  Parser(String path) {
    _document = XmlDocument.parse(util.readString(path));
    _characterElement = getRootElement(_document, 'character');
    _informationElement = getElement(_characterElement, 'information');
    _displayPropertiesElement =
        getElement(_characterElement, 'display-properties');
    _buildElement = getElement(_characterElement, 'build');
  }

  void parse() {
    _processInformationElement();
    _processDisplayInformationElement();
    _processBuildElement();
  }

  /// Process the 'display-information' tag.
  void _processInformationElement() {
    character.group = getElementValueText(_informationElement, 'group');
  }

  /// Process the 'display-information' tag.
  void _processDisplayInformationElement() {
    // race
    character.race = getElementValueText(_displayPropertiesElement, 'race');
    // class
    character.className =
        getElementValueText(_displayPropertiesElement, 'class');
    // background roll
    character.background.roll =
        getElementValueText(_displayPropertiesElement, 'background');
    // level
    character.level = getElementValueNumber(_displayPropertiesElement, 'level');
    // portrait
    XmlElement portraitElement =
        getElement(_displayPropertiesElement, 'portrait');
    character.characterPortrait
        .setBase64(getElementValueText(portraitElement, 'base64'));
    character.companionPortrait
        .setPath(getElementValueText(portraitElement, 'companion'));
  }

  /// Process the 'build' tag.
  void _processBuildElement() {
    XmlElement inputElement = getElement(_buildElement, 'input');
    _processBasicInformation(inputElement);
    _processAttacks(inputElement);
    _processBackstory(inputElement);
    _processOrganization(inputElement);
    _processAdditionalFeature(inputElement);
    _processInventory(inputElement);
    _processNotes(inputElement);
    _processQuest(inputElement);

    _processAppearanceElement();
    _processAbilitiesElement();
  }

  /// Process the basic information of a character.
  void _processBasicInformation(XmlElement inputElement) {
    // name
    character.name = getElementValueText(inputElement, 'name');
    // gender
    character.gender = getElementValueText(inputElement, 'gender');
    // player name
    character.playerName = getElementValueText(inputElement, 'player-name');
    // experience
    character.experience = getElementValueNumber(inputElement, 'experience');
  }

  /// Process the attacks of a character.
  void _processAttacks(XmlElement inputElement) {
    // attacks
    XmlElement attacksElement = getElement(inputElement, 'attacks');
    Attack tmpAttack;
    for (XmlElement attackElement in attacksElement.childElements) {
      if (attackElement.name.toString() == 'attack') {
        tmpAttack = Attack();
        tmpAttack.name = getAttributeValueText(attackElement, 'name');
        Map<String, Range> ranges =
            Range.parse(getAttributeValueText(attackElement, 'range'));
        tmpAttack.shortRange = ranges['short']!;
        tmpAttack.longRange = ranges['long']!;
        tmpAttack.setAttack(getAttributeValueText(attackElement, 'attack'));
        tmpAttack.damage =
            Damage.parse(getAttributeValueText(attackElement, 'damage'));
        tmpAttack.ability = Ability.values.byName(
            getAttributeValueText(attackElement, 'ability').toLowerCase());
        character.attacks.add(tmpAttack);
      }
    }
  }

  /// Process the backstory.
  void _processBackstory(XmlElement inputElement) {
    // backstory
    character.background.story = getElementValueText(inputElement, 'backstory');
    character.background.trinket =
        getElementValueText(inputElement, 'background-trinket');
    character.background.traits =
        getElementValueText(inputElement, 'background-traits');
    character.background.ideals =
        getElementValueText(inputElement, 'background-ideals');
    character.background.bonds =
        getElementValueText(inputElement, 'background-bonds');
    character.background.flaws =
        getElementValueText(inputElement, 'background-flaws');
    XmlElement featureElement =
        getElement(getElement(inputElement, 'background'), 'feature');
    character.background.feature = Feature(
        getAttributeValueText(featureElement, 'name'),
        getElementValueText(featureElement, 'description'));
  }

  /// Process which organization the character is aligned with.
  void _processOrganization(XmlElement inputElement) {
    // organization
    XmlElement organizationElement = getElement(inputElement, 'organization');
    character.organization =
        Organization(getElementValueText(organizationElement, 'name'));
    character.organization.symbol =
        util.read(getElementValueText(organizationElement, 'symbol'));
    character.organization.allies =
        getElementValueText(organizationElement, 'allies');
  }

  /// Process the additional Features.
  void _processAdditionalFeature(XmlElement inputElement) {
    // additional feature
    character.additionalFeatures =
        getElementValueText(inputElement, 'additional-features');
  }

  /// Process the items of the character (i.e coins, ...).
  void _processInventory(XmlElement inputElement) {
    // currency, inventory and treasure
    XmlElement currencyElement = getElement(inputElement, 'currency');
    for (Coin c in Coin.values) {
      character.inventory
          .setCoin(c, getElementValueNumber(currencyElement, c.name));
    }
    character.inventory.equipment =
        getElementValueText(currencyElement, 'equipment');
    character.inventory.treasure =
        getElementValueText(currencyElement, 'treasure');
  }

  /// Process the notes of the character sheets.
  void _processNotes(XmlElement inputElement) {
    // notes
    XmlElement notesElement = getElement(inputElement, 'notes');
    for (XmlElement note in notesElement.childElements) {
      character.notes.putIfAbsent(
          getAttributeValueText(note, 'column'), () => getText(note));
    }
  }

  /// Process the quest.
  void _processQuest(XmlElement inputElement) {
    // quest
    character.quest = getElementValueText(inputElement, 'quest');
  }

  /// Process the 'appearance' tag.
  void _processAppearanceElement() {
    XmlElement appearanceElement = getElement(_buildElement, 'appearance');
    character.appearance.age = getElementValueNumber(appearanceElement, 'age');
    character.appearance.height =
        getElementValueText(appearanceElement, 'height');
    character.appearance.weight =
        getElementValueText(appearanceElement, 'weight');
    character.appearance.eyes = getElementValueText(appearanceElement, 'eyes');
    character.appearance.skin = getElementValueText(appearanceElement, 'skin');
    character.appearance.hair = getElementValueText(appearanceElement, 'hair');
  }

  /// Process the abilities of the character.
  void _processAbilitiesElement() {
    XmlElement abilitiesElement = getElement(_buildElement, 'abilities');
    for (Ability ability in Ability.values) {
      character.abilities.putIfAbsent(
          ability, () => getElementValueNumber(abilitiesElement, ability.name));
    }
  }
}
