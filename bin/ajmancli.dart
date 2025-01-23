import 'dart:io';
import 'package:ajmancli/add_intl/add_intl.dart';
import 'package:ajmancli/constants/enums/command_enum.dart';
import 'package:ajmancli/constants/enums/flag_enum.dart';
import 'package:ajmancli/constants/enums/option_enum.dart';
import 'package:ajmancli/gen_page/gen_page.dart';

import 'package:args/args.dart';

void main(List<String> arguments) {
  final parser = ArgParser();

  parser.addCommand(
    CommandEnum.genpage.name,
    ArgParser()
      ..addOption(
        OptionEnum.name.name,
        abbr: OptionEnum.name.name[0],
        help: 'Name of the page to generate',
      )
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
    help: 'Show usage information',
  );

  final argResults = parser.parse(arguments);

  if (argResults[FlagEnum.help.name] as bool || argResults.command == null) {
    print('Usage: ajmancli ${CommandEnum.genpage.name} -n <PageName> [-a <AddArgs>]');
    print('Usage: ajmancli ${CommandEnum.addintl.name} -v <Value String> [-a <ArabicString>]');
    print(parser.usage);
    exit(0);
  }

  if (argResults.command!.name == CommandEnum.genpage.name) {
    final name = argResults.command![OptionEnum.name.name] as String?;
    final addArgs = argResults.command![FlagEnum.args.name] as bool;
    // Check if name is null or empty
    if (name == null || name.trim().isEmpty) {
      print(
          '\x1B[31mError: Page name is required.\nUsage: ajmancli ${CommandEnum.genpage.name} -n <PageName>\x1B[0m');
      exit(1);
    }

    // Regular expression to validate the name (alphanumeric only, no spaces)
    final invalidNamePattern = RegExp(r'[^a-zA-Z0-9]');
    if (invalidNamePattern.hasMatch(name) || name.contains(' ')) {
      print(
          '\x1B[31mError: Page name can only contain alphanumeric characters (letters and numbers) and no spaces.\x1B[0m');
      exit(1);
    }

    // If validation passes, call generatePage
    generatePage(name, addArgs);
  } else if (argResults.command!.name == CommandEnum.addintl.name) {
    final value = argResults.command![OptionEnum.value.name] as String?;
    final arabic = argResults.command![OptionEnum.arabic.name] as String?;
    if (value == null) {
      print('Error: Value is required.\nUsage: ajmancli addintl -v <String> [-a <ArabicString>]');
      exit(1);
    }
    addStringToArbFiles(value, arabic);
  } else {
    print('Unknown command. Use --help for usage information.');
    exit(1);
  }
}
