import 'dart:io';

/// some useful utilities.

bool exists(String path) {
  return File(path).existsSync();
}

String read(String path) {
  try {
    return File(path).readAsStringSync();
  } on FileSystemException catch (fe) {
    stderr.writeln('${fe.message} \'$path\'');
    exit(1);
  }
}
