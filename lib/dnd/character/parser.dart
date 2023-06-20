import 'package:helios/dnd/character/character.dart' show Character;
import 'package:helios/util/file.dart' as util;
import 'package:helios/util/xml.dart'
    show getElement, getRootElement, getElementValueText, getElementValueNumber;
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
    _document = XmlDocument.parse(util.read(path));
    _characterElement = getRootElement(_document, 'character');
    _informationElement = getElement(_characterElement, 'information');
    _displayPropertiesElement =
        getElement(_characterElement, 'display-properties');
    _buildElement = getElement(_characterElement, 'build');
  }

  parse() {
    _processDisplayInformationElement();
  }

  _processDisplayInformationElement() {
    character.name = getElementValueText(_displayPropertiesElement, 'name');
    character.race = getElementValueText(_displayPropertiesElement, 'race');
    character.className =
        getElementValueText(_displayPropertiesElement, 'class');
    character.background.roll =
        getElementValueText(_displayPropertiesElement, 'background');
    character.level = getElementValueNumber(_displayPropertiesElement, 'level');
    XmlElement portraitElement =
        getElement(_displayPropertiesElement, 'portrait');
    character.characterPortrait
        .setBase64(getElementValueText(portraitElement, 'base64'));
    character.companionPortrait
        .setPath(getElementValueText(portraitElement, 'companion'));
  }
}
