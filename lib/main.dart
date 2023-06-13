import 'argparse/parser.dart';

void main(List<String> args) {
  List<String> parsedArgs = Parser.parse(args);
  if (parsedArgs.isNotEmpty) Runner.run(parsedArgs);
}
