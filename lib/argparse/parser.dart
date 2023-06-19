import 'dart:io';

import 'package:args/args.dart' show ArgParser, ArgResults;
import 'package:helios/dnd/character/parser.dart' as char;
import 'package:helios/messages/args.dart' show ArgErrorMessages;
import 'package:helios/util/file.dart' as util;

/// Parse commandline arguments.
class Parser {
  static final ArgParser _parser = ArgParser();

  /// Parse the arguments.
  static ArgResults parse(List<String> args) {
    _parser.addFlag('help',
        abbr: 'h', negatable: false, help: 'Show this help message.');
    _parser.addFlag('version',
        abbr: 'v', negatable: false, help: 'Display version.');
    _parser.addOption('input',
        abbr: 'i', valueHelp: 'file', help: 'Input .dnd5e file.');
    _parser.addFlag('display',
        negatable: false, help: 'Display a character in stdout.');

    try {
      return _parser.parse(args);
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
  static run(ArgResults parsedArgs) {
    List<String> arguments = parsedArgs.arguments;
    char.Parser characterParser = char.Parser.empty();
    bool isInput = false;

    for (int i = 0; i < arguments.length; i++) {
      switch (arguments[i]) {
        case '-h' || '--help':
          Parser.printUsage();
          exit(0);
        case '-v' || '--version':
          // TODO: Display Version
          stdout.writeln('WIP');
          exit(0);
        case '-i' || '--input':
          if (util.exists(arguments[i + 1])) {
            characterParser = char.Parser.path(arguments[i + 1]);
            characterParser.parse();
            isInput = true;
          }
          break;
        case '--display':
          // if the character has been parsed.
          if (isInput) {
            stdout.writeln(characterParser.character);
          } else {
            stderr.writeln(ArgErrorMessages.missingInput.message);
          }
          break;
      }
    }
  }
}
