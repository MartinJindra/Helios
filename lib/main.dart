import 'package:helios/argparser/parser.dart';

void main(List<String> args) {
  final p = Parser();
  List<String> parsedArgs = p.parse(args);
  Runner.run(parsedArgs);
}
