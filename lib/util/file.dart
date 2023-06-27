import 'dart:io' show File, FileSystemException, Platform, exit, stderr;

import 'package:file_picker/file_picker.dart';

/// some useful utilities.

/// does file exists.
bool exists(String path) {
  return File(path).existsSync();
}

/// read all contents as a string from a file.
String readString(String path) {
  try {
    return File(path).readAsStringSync();
  } on FileSystemException catch (fe) {
    stderr.writeln('${fe.message} \'$path\'');
    exit(1);
  }
}

/// read all contents as a byte list from a file.
List<int> read(String path) {
  try {
    return File(path).readAsBytesSync();
  } on FileSystemException catch (fe) {
    stderr.writeln('${fe.message} \'$path\'');
    return List.empty();
  }
}

/// Write content to a file.
/// Returns it operation was successful.
bool write(String path, List<int> content) {
  try {
    File f = File(path);
    f.createSync();
    f.writeAsBytesSync(content);
  } on FileSystemException catch (fe) {
    stderr.writeln('${fe.message} \'$path\'');
    return false;
  }
  return true;
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

Future<String> openFilePicker() async {
  FilePickerResult? file;
  if (Platform.isAndroid || Platform.isIOS) {
    file = await FilePicker.platform.pickFiles();
    return file?.files.single.path ?? '';
  } else {
    file = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['dnd5e'],
    );
    return file?.files.single.path ?? '';
  }
}
