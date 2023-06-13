import 'dart:io';

import 'package:args/args.dart' show ArgParser;

/// Parse commandline arguments.
class Parser {
  static final ArgParser _parser = ArgParser();

  Parser() {
    _parser.addOption('input',
        abbr: 'i', valueHelp: 'file', help: 'Input .dnd5e file.');
    _parser.addFlag('help',
        abbr: 'h', negatable: false, help: 'Show this help message.');
    final display = ArgParser();
    _parser.addCommand('display', display);
  }

  /// Parse the arguments.
  List<String> parse(List<String> args) {
    try {
      return _parser.parse(args).arguments;
    } on FormatException catch (fe) {
      stderr.write(fe.message);
      exit(1);
    }
  }

  /// Print the help message.
  static printUsage() {
    stdout.write(_parser.usage);
  }
}

class Runner {

  /// Run the parsed arguments.
  static run(List<String> parsedArgs) {
    for (String arg in parsedArgs) {
      switch (arg) {
        case "-h":
          Parser.printUsage();
          break;
      }
    }
  }

}
