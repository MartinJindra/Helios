import 'package:helios/dnd/character/character.dart' show Character;
import 'package:helios/util/file.dart' as util;
import 'package:helios/util/xml.dart'
    show getElement, getRootElement, getElementText;
import 'package:xml/xml.dart' show XmlDocument, XmlElement;

class Parser {
  late Character character = Character('');
  late final XmlDocument _document;
  late final XmlElement _characterElement,
      _informationElement,
      _displayPropertiesElement,
      _buildElement;

  Parser.empty();

  Parser.path(String path) {
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

  _processDisplayInformationElement() {}
}
