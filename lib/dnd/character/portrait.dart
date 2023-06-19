import 'dart:convert' show Base64Decoder;
import 'dart:io' show File, stderr;

import 'package:helios/util/file.dart' as util;

/// A character or companion portrait
class Portrait {
  late List<int> _bytes;

  /// Specify a portrait via a file path.
  Portrait.path(String path) {
    if (util.exists(path)) {
      _bytes = File(path).readAsBytesSync();
    } else {
      stderr.writeln('\'$path\' does not exists.');
    }
  }

  /// Set a portrait as an Base64 encoded image.
  Portrait.base64(String base64) {
    _bytes = const Base64Decoder().convert(base64);
  }

  /// Write a portrait to the filesystem.
  void write(String path) {
    util.write(path, _bytes);
  }
}
