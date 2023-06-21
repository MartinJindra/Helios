import 'package:helios/util/file.dart' as util;

/// An organization for DnD.
class Organization {
  final String name;
  String allies = '';
  List<int> symbol = List.empty();

  Organization(this.name);

  ///Set the symbol of an organization via a path.
  void setSymbol(String symbolPath) {
    if (symbolPath.isNotEmpty) {
      symbol = util.read(symbolPath);
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
