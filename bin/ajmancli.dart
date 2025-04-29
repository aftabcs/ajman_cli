import 'dart:io';
import 'package:ajmancli/add_intl/add_intl.dart';
import 'package:ajmancli/app_api/add_api.dart';
import 'package:ajmancli/build/build.dart';
import 'package:ajmancli/constants/enums/command_enum.dart';
import 'package:ajmancli/constants/enums/flag_enum.dart';
import 'package:ajmancli/constants/enums/option_enum.dart';
import 'package:ajmancli/gen_page/gen_page.dart';
import 'package:ajmancli/utils/cli_arg_parser.dart';
import 'package:ajmancli/utils/common_utils.dart';

import 'package:args/args.dart';

void main(List<String> arguments) async {
  ArgResults? argResults = CliArgParser.parse(arguments);

  if (argResults?[FlagEnum.version.name] as bool) {
    print('Ajman CLI version: ${CommonUtils.pubSpec()?.version}');
    exit(0);
  }

  if (argResults?[FlagEnum.help.name] as bool) {
    print('Usage: ajman ${CommandEnum.genpage.name} -n <PageName> [-a <AddArgs>]');
    print('Usage: ajman ${CommandEnum.addintl.name} -v <Value String> [-a <ArabicString>]');
    print('Usage: ajman ${CommandEnum.build.name} <environment>');
    print(CliArgParser.parser.usage);
    exit(0);
  }

  if (argResults?.command?.name == CommandEnum.genpage.name) {
    final name = argResults?.command![OptionEnum.name.name] as String?;
    final addArgs = argResults?.command![FlagEnum.args.name] as bool;
    // Check if name is null or empty
    if (name == null || name.trim().isEmpty) {
      print(
        '\x1B[31mError: Page name is required.\nUsage: ajman ${CommandEnum.genpage.name} -n <PageName> [-a <AddArgs>]\x1B[0m',
      );
      exit(1);
    }

    // Regular expression to validate the name (alphanumeric only, no spaces)
    final invalidNamePattern = RegExp(r'[^a-zA-Z0-9]');
    if (invalidNamePattern.hasMatch(name) || name.contains(' ')) {
      print(
        '\x1B[31mError: Page name can only contain alphanumeric characters (letters and numbers) and no spaces.\x1B[0m',
      );
      exit(1);
    }

    // If validation passes, call generatePage
    generatePage(name, addArgs);
  } else if (argResults?.command?.name == CommandEnum.addintl.name) {
    final value = argResults?.command![OptionEnum.value.name] as String?;
    final arabic = argResults?.command![OptionEnum.arabic.name] as String?;
    if (value == null) {
      print('\x1B[31mError: Value is required.\nUsage: ajman addintl -v <String> [-a <ArabicString>]\x1B[0m');
      exit(1);
    }
    addStringToArbFiles(value, arabic);
  } else if (argResults?.command?.name == CommandEnum.build.name) {
    // Handle the build command
    if (argResults!.command!.rest.length != 1) {
      print('\x1B[31mError: build command requires exactly one argument: <environment>\x1B[0m');
      print('Example: ajman build dev');
      exit(1);
    }
    String environment = argResults.command!.rest[0];
    // buildApkWithMakeFile(environment);
    buildApkWithProcess(environment);
  } else if (argResults?.command?.name == CommandEnum.addapi.name) {
    final String uses =
        "Usage: ajman ${CommandEnum.addapi.name} -n <ApiName> -f <FeatureName> [-l <ListObjectName>] [-r]";
    final String? name = argResults?.command![OptionEnum.name.name] as String?;
    final String? feature = argResults?.command![OptionEnum.feature.name] as String?;
    final String? list = argResults?.command![OptionEnum.list.name] as String?;
    final bool genReqEnt = argResults?.command![FlagEnum.request.name] as bool? ?? false;

    //? Check if name is null or empty
    if (name == null || name.trim().isEmpty) {
      print('\x1B[31mError: API name is required.\n$uses\x1B[0m');
      exit(1);
    }
    //? Check if feature is null or empty
    if (feature == null || feature.trim().isEmpty) {
      print('\x1B[31mError: Feature name is required.\n$uses\x1B[0m');
      exit(1);
    }

    //? Ensure the command is run from the root directory (ajman_flutter)
    final currentDirectory = Directory.current.path;
    if (!currentDirectory.endsWith('ajman_flutter')) {
      print('This command must be run in the root folder (ajman_flutter)');
      return;
    }

    //? Regular expression to validate the name (alphanumeric only, no spaces)
    final invalidNamePattern = RegExp(r'[^a-zA-Z0-9]');
    if (invalidNamePattern.hasMatch(name) || name.contains(' ')) {
      print(
        '\x1B[31mError: API name can only contain alphanumeric characters (letters and numbers) and no spaces.\x1B[0m',
      );
      exit(1);
    }

    addApi(name, feature, list, genReqEnt);
  } else {
    print(CliArgParser.parser.usage);
    exit(1);
  }
}
