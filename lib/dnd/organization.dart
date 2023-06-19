import 'dart:io' show File;

/// An organization for DnD.
class Organization {
  late final String name, allies;
  late List<int> symbol;

  Organization(this.name, this.allies);

  ///Set the symbol of an organization via a path.
  void setSymbol(String symbolPath) {
    File f = File(symbolPath);
    if (f.existsSync()) {
      symbol = f.readAsBytesSync();
    }
  }

  @override
  String toString() {
    StringBuffer str = StringBuffer();
    str.writeln('## Organization $name');
    str.writeln('Allies: $allies');
    return str.toString();
  }
}
