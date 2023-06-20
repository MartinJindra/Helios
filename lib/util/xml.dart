import 'package:xml/xml.dart'
    show XmlDocument, XmlElement, XmlName, XmlStringExtension;

/// Null safe implementation for getting a child element.
XmlElement getElement(XmlElement parent, String childName) =>
    parent.getElement(childName) ?? XmlElement(XmlName(childName));

/// Null safe implementation for getting the root element of a document.
XmlElement getRootElement(XmlDocument document, String childName) =>
    document.getElement(childName) ?? XmlElement(XmlName(childName));

/// Null safe implementation for getting the text of a child element.
String getElementValueText(XmlElement parent, String childName) {
  XmlElement childElement =
      parent.getElement(childName) ?? XmlElement(XmlName(childName));
  return childElement.innerText == 'null' ? '' : childElement.innerText.trim();
}

/// Null safe implementation for getting the number of a child element.
int getElementValueNumber(XmlElement parent, String childName) {
  XmlElement childElement =
      parent.getElement(childName) ?? XmlElement(XmlName(childName));
  try {
    return childElement.innerText == 'null'
        ? 0
        : int.parse(childElement.innerText);
  } on FormatException {
    return 0;
  }
}

/// Null safe implementation for getting
/// the value of an attribute from an element.
String getAttributeValueText(XmlElement element, String name) {
  return element.getAttribute(name) ?? '';
}
