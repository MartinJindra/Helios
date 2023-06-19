import 'dart:io' show File, FileSystemException, exit, stderr;

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

/// Write content to a file.
/// Returns it operation was successful.
bool write(String path, List<int> content) {
  if (!exists(path)) {
    try {
      File(path).writeAsBytesSync(content);
    } on FileSystemException catch (fe) {
      stderr.writeln('${fe.message} \'$path\'');
    }
    return true;
  } else {
    stderr.writeln('File $path already exists and not overwriting it.');
    return false;
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
