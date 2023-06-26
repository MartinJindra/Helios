String removeLast(String expr, String char) {
  int index = expr.lastIndexOf(char);
  return expr.substring(0, index);
}
