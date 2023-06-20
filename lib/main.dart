import 'package:args/args.dart' show ArgResults;
import 'package:helios/argparse/parser.dart' show Parser, Runner;

void main(List<String> args) {
  ArgResults parsedArgs = Parser.parse(args);
  if (parsedArgs.arguments.isNotEmpty) Runner.run(parsedArgs);
}
