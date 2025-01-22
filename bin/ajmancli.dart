import 'dart:io';
import 'package:args/args.dart';

void main(List<String> arguments) {
  final parser = ArgParser()
    ..addCommand('genpage', ArgParser()..addOption('name', abbr: 'n', help: 'Name of the page to generate'))
    ..addFlag('help', abbr: 'h', negatable: false, help: 'Show usage information');

  final argResults = parser.parse(arguments);

  if (argResults['help'] as bool || argResults.command == null) {
    print('Usage: ajmancli genpage -n <PageName>');
    print(parser.usage);
    exit(0);
  }

  if (argResults.command!.name == 'genpage') {
    final name = argResults.command!['name'] as String?;
    if (name == null) {
      print('Error: Page name is required.\nUsage: ajman_cli genpage -n <PageName>');
      exit(1);
    }
    generatePage(name.replaceAll(" ", ""));
  } else {
    print('Unknown command. Use --help for usage information.');
    exit(1);
  }
}

void generatePage(String name) {
  final folderName = _toSnakeCase(name);
  final folder = Directory(folderName);

  if (!folder.existsSync()) {
    folder.createSync();
  }

  final files = {
    '${folderName}_page.dart': _pageTemplate(name),
    '${folderName}_page_view.dart': _pageViewTemplate(name),
    '${folderName}_page_view_model.dart': _pageViewModelTemplate(name),
  };

  files.forEach((fileName, content) {
    final file = File('${folder.path}/$fileName');
    if (!file.existsSync()) {
      file.writeAsStringSync(content);
      print('Created: ${file.path}');
    } else {
      print('Skipped (already exists): ${file.path}');
    }
  });

  print('✅ Files generated successfully in ${folder.path}');
}

String _toSnakeCase(String input) {
  return input.replaceAllMapped(RegExp(r'[A-Z]'), (match) {
    return '_${match.group(0)!.toLowerCase()}';
  }).replaceFirst('_', '');
}

String _toLowerCaseFirstLetter(String input) {
  if (input.isEmpty) return input; // Return empty string if input is empty
  return input[0].toLowerCase() + input.substring(1);
}

String _pageTemplate(String name) {
  final className = '${name}Page';
  return '''
import 'package:ajman/base/base_page.dart';
import 'package:ajman/generated/l10n.dart';
import 'package:ajman/ui/molecules/app_bar_with_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '${_toSnakeCase(name)}_page_view_model.dart';
import '${_toSnakeCase(name)}_page_view.dart';

class $className extends BasePage<${className}ViewModel> {
  const $className({super.key});

  @override
  State<StatefulWidget> createState() => ${className}State();
}

class ${className}State extends BaseStatefulPage<${className}ViewModel, $className> {
  @override
  Widget buildView(BuildContext context, ${className}ViewModel model) {
    return ${className}View(
      provideBase(),
    );
  }

  @override
  PreferredSizeWidget? buildAppbar() {
    return appBarWithProgress(
      wantProgress: true,
      wantLeadingBackButton: true,
      wantCrossButton: false,
      title: Text(S.of(context).name),
      progress: 50,
    );
  }

  @override
  void didChangeDependencies() {
    final ${className}ViewModel model =
        ProviderScope.containerOf(context).read(${_toLowerCaseFirstLetter(className)}ViewModelProvider);
    super.didChangeDependencies();
  }

  @override
  ProviderBase provideBase() => ${_toLowerCaseFirstLetter(className)}ViewModelProvider;
}


var ${_toLowerCaseFirstLetter(className)}ViewModelProvider =
    ChangeNotifierProvider.autoDispose<${className}ViewModel>(
        (ref) => ${className}ViewModel());

''';
}

String _pageViewTemplate(String name) {
  final className = '${name}PageView';
  return '''
import 'package:ajman/base/base_page.dart';
import 'package:flutter/material.dart';

import '${_toSnakeCase(name)}_page_view_model.dart';

class $className extends BasePageViewWidget<${className}Model> {
  const $className(super.providerBase, {super.key});

  @override
  Widget build(BuildContext context, ${className}Model model) {
    return Placeholder();
  }
}
''';
}

String _pageViewModelTemplate(String name) {
  final className = '${name}PageViewModel';
  return '''
import 'package:ajman/base/base_page_view_model.dart';


class $className extends BasePageViewModel {
  $className();


  @override
  void dispose() {
    super.dispose();
  }
}
''';
}
