enum Types {
  option('Option'),
  level('Level'),
  magicItem('Magic Item'),
  armor('Armor');

  const Types(this._text);

  final String _text;

  String get text => _text;
}

enum Name {
  feats('Feats'),
  multiclassing('Multiclassing');

  const Name(this._text);

  final String _text;

  String get text => _text;
}
