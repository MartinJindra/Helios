import 'dart:io';

/// some useful utilities.

/// does file exists.
bool exists(String path) {
  return File(path).existsSync();
}

/// read all contents from a file.
String read(String path) {
  try {
    return File(path).readAsStringSync();
  } on FileSystemException catch (fe) {
    stderr.writeln('${fe.message} \'$path\'');
    exit(1);
  }
}

/// Check if a list of paths exists.
bool pathsExists(List<String> paths) {
  for (String path in paths) {
    if (!exists(path)) {
      return false;
    }
  }
  return true;
}
