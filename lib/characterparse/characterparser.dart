import 'package:helios/character/character.dart';
import 'package:helios/util/file.dart' as util;
import 'package:helios/util/xml.dart'
    show getElement, getRootElement, getElementText;
import 'package:xml/xml.dart';

class CharacterParser {
  late Character _character;
  late final XmlDocument _document;
  late final XmlElement _characterElement,
      _informationElement,
      _displayPropertiesElement,
      _buildElement;

  CharacterParser(String path) {
    _document = XmlDocument.parse(util.read(path));
    _characterElement = getRootElement(_document, 'character');
    _informationElement = getElement(_characterElement, 'information');
    _displayPropertiesElement =
        getElement(_characterElement, 'display-properties');
    _buildElement = getElement(_characterElement, 'build');
    _character = Character(_getCharacterName());
  }

  Character getCharacter() {
    return _character;
  }

  String _getCharacterName() {
    return getElementText(_displayPropertiesElement, 'name');
  }

  parse() {
    _getCharacterInformation();
  }

  _getCharacterInformation() {}
}
