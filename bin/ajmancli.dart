import 'dart:io';
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

  parser.addFlag(
    FlagEnum.help.name,
    abbr: FlagEnum.help.name[0],
    negatable: false,
    help: 'Show usage information',
  );

  final argResults = parser.parse(arguments);

  if (argResults[FlagEnum.help.name] as bool || argResults.command == null) {
    print('Usage: ajmancli ${CommandEnum.genpage.name} -n <PageName>');
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
  } else {
    print('Unknown command. Use --help for usage information.');
    exit(1);
  }
}
