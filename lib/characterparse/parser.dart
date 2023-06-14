import 'package:helios/util/file.dart' as util;
import 'package:xml/xml.dart' show XmlDocument;

class CharacterParser {
  late final XmlDocument document;

  CharacterParser(String path) {
    document = XmlDocument.parse(util.read(path));
  }
}
