import 'package:helios/util/file.dart' as util;
import 'package:helios/util/xml.dart'
    show getElement, getRootElement, getElementText;
import 'package:xml/xml.dart';

class CharacterParser {
  late final XmlDocument document;

  CharacterParser(String path) {
    document = XmlDocument.parse(util.read(path));
  }

  parse() {
    XmlElement characterElement = getRootElement(document, 'character');
    XmlElement informationElement = getElement(characterElement, 'information');
    XmlElement displayPropertiesElement =
        getElement(characterElement, 'display-properties');
    XmlElement buildElement = getElement(characterElement, 'build');
  }
}
