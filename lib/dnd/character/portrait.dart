import 'dart:convert' show Base64Decoder;

import 'package:helios/util/file.dart' as util;

/// A character or companion portrait
class Portrait {
  late List<int> _bytes;

  Portrait();

  /// Specify a portrait via a file path.
  setPath(String path) {
    _bytes = util.read(path);
  }

  /// Set a portrait as an Base64 encoded image.
  setBase64(String base64) {
    _bytes = const Base64Decoder().convert(base64);
  }

  /// Write a portrait to the filesystem.
  void write(String path) {
    util.write(path, _bytes);
  }
}
