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
    print('Usage: ajmancli ${CommandEnum.genpage.name} -n <PageName>');
    print('Usage: ajmancli ${CommandEnum.addintl.name} -v <Value String> [-a <ArabicString>]');
    print(parser.usage);
    exit(0);
  }

  if (argResults.command!.name == CommandEnum.genpage.name) {
    final name = argResults.command![OptionEnum.name.name] as String?;
    if (name == null) {
      print('Error: Page name is required.\nUsage: ajmancli ${CommandEnum.genpage.name} -n <PageName>');
      exit(1);
    }
    generatePage(name.replaceAll(" ", ""));
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
