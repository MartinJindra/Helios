import 'package:xml/xml.dart'
    show XmlDocument, XmlElement, XmlName, XmlStringExtension;

/// Null safe implementation for getting a child element.
XmlElement getElement(XmlElement parent, String childName) =>
    parent.getElement(childName) ?? XmlElement(XmlName(childName));

/// Null safe implementation for getting the root element of a document.
XmlElement getRootElement(XmlDocument document, String childName) =>
    document.getElement(childName) ?? XmlElement(XmlName(childName));

/// Null safe implementation for getting the value of a child element.
String getElementText(XmlElement parent, String childName) {
  XmlElement childElement =
      parent.getElement(childName) ?? XmlElement(XmlName(childName));
  return childElement.innerText == 'null' ? '' : childElement.innerText;
}
