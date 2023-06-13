import 'package:args/args.dart' show ArgResults;

import 'argparse/parser.dart';

void main(List<String> args) {
  ArgResults parsedArgs = Parser.parse(args);
  if (parsedArgs.arguments.isNotEmpty) Runner.run(parsedArgs);
}
