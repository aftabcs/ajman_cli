import 'dart:io';

import 'package:ajmancli/constants/enums/command_enum.dart';
import 'package:ajmancli/constants/enums/flag_enum.dart';
import 'package:ajmancli/constants/enums/option_enum.dart';
import 'package:args/args.dart';

abstract class CliArgParser {
  static final parser = ArgParser();
  static ArgResults? parse(List<String> arguments) {
    parser.addCommand(
      CommandEnum.genpage.name,
      ArgParser()
        ..addOption(OptionEnum.name.name, abbr: OptionEnum.name.name[0], help: 'Name of the page to generate')
        ..addFlag(
          FlagEnum.args.name, // Optional boolean flag
          abbr: 'a', // Short abbreviation
          defaultsTo: false, // Default value
          help: 'Use to generate args',
        ),
    );

    parser.addCommand(
      CommandEnum.addintl.name,
      ArgParser()
        ..addOption(
          OptionEnum.value.name,
          abbr: OptionEnum.value.name[0],
          help: 'Value to add to the .arb files',
        )
        ..addOption(
          OptionEnum.arabic.name,
          abbr: OptionEnum.arabic.name[0],
          help: 'Arabic string to add to intl_ar.arb',
        ),
    );

    parser.addFlag(
      FlagEnum.help.name,
      abbr: FlagEnum.help.name[0],
      negatable: false,
      help: 'View usage information',
    );

    parser.addFlag(
      FlagEnum.version.name,
      abbr: FlagEnum.version.name[0],
      negatable: false,
      help: 'View current version',
    );

    ArgResults? argResults;

    try {
      argResults = parser.parse(arguments);
    } on FormatException catch (e) {
      print('\x1B[31mError: ${e.message}\x1B[0m');
      print('Use `ajman --help` to see available commands and options.');
      exit(1);
    }

    return argResults;
  }
}
