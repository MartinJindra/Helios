import 'dart:io' show Platform;

String removeLast(String expr, String char) {
  int index = expr.lastIndexOf(char);
  return expr.substring(0, index);
}

String basename(String path) {
  return path.substring(path.lastIndexOf(Platform.pathSeparator) + 1);
}
