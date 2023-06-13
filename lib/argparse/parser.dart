import 'dart:io';

import 'package:args/args.dart' show ArgParser;

/// Parse commandline arguments.
class Parser {
  static final ArgParser _parser = ArgParser();

  /// Parse the arguments.
  static List<String> parse(List<String> args) {
    _parser.addOption('input',
        abbr: 'i', valueHelp: 'file', help: 'Input .dnd5e file.');
    _parser.addFlag('help',
        abbr: 'h', negatable: false, help: 'Show this help message.');
    _parser.addFlag('version',
        abbr: 'v', negatable: false, help: 'Display version.');
    final display = ArgParser();
    _parser.addCommand('display', display);

    try {
      return _parser.parse(args).arguments;
    } on FormatException catch (fe) {
      stderr.writeln(fe.message);
      exit(1);
    }
  }

  /// Print the help message.
  static printUsage() {
    stdout.writeln(_parser.usage);
  }
}

class Runner {
  /// Run the parsed arguments.
  static run(List<String> parsedArgs) async {
    for (String arg in parsedArgs) {
      switch (arg) {
        case '-h' || '--help':
          Parser.printUsage();
          exit(0);
        case '-v' || '--version':
          // TODO: Display Version
          stdout.writeln('WIP');
          exit(0);
      }
    }
  }
}
