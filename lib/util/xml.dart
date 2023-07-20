import 'package:xml/xml.dart'
    show XmlDocument, XmlElement, XmlNode, XmlStringExtension;
import 'package:xml/xpath.dart';

class XMLGetter {
  final XmlDocument _document;

  XMLGetter(this._document);

  List<XmlElement> elements(String expr) {
    List<XmlElement> list = [];
    for (var el in _document.xpath(expr)) {
      list.add(el as XmlElement);
    }
    return list;
  }

  /// Null safe implementation for getting the text of an element.
  String txt(String expr) {
    try {
      return val(_document.xpath(expr).first);
    } on StateError {
      return '';
    }
  }

  /// Null safe implementation for getting the number of an element.
  int num(String expr) {
    try {
      return int.parse(val(_document.xpath(expr).first));
    } on StateError {
      return 0;
    } on FormatException {
      return 0;
    }
  }

  /// Null safe implementation for getting
  /// the value of an attribute value from an element.
  String attrValTxt(String expr, String name) {
    return (_document.xpath(expr).first as XmlElement).getAttribute(name) ?? '';
  }

  static String val(XmlNode node) {
    return node.innerText == 'null' ? '' : node.innerText.trim();
  }

  static String attrValTxtWithElement(XmlElement element, String name) {
    return element.getAttribute(name) ?? '';
  }
}
