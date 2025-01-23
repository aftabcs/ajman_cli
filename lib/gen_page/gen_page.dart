import 'dart:io';

import 'package:ajmancli/utils/text_utils.dart';

import './templates/page_template.dart';
import './templates/page_view_template.dart';
import './templates/page_view_model_template.dart';

void generatePage(String name, bool addArgs) {
  final folderName = TextUtils.toSnakeCase(name);
  final folder = Directory(folderName);

  if (!folder.existsSync()) {
    folder.createSync();
  }

  final files = {
    '${folderName}_page.dart': pageTemplate(name, addArgs),
    '${folderName}_page_view.dart': pageViewTemplate(name),
    '${folderName}_page_view_model.dart': pageViewModelTemplate(name, addArgs),
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
  addToRoutePaths(name);
}

const String routePathsFile = 'lib/main/navigation/route_paths.dart';
void addToRoutePaths(String pageName) {
  final file = File(routePathsFile);

  if (!file.existsSync()) {
    print('Error: $routePathsFile does not exist.');
    return;
  }

  final routeConstant =
      '  static const String ${_toCamelCase(pageName)}Page = "${_toCamelCase(pageName)}Page";\n';

  // Insert the new route constant before the closing brace of the class
  final content = file.readAsStringSync();
  final updatedContent = content.replaceFirstMapped(
    RegExp(r'(class RoutePaths \{[\s\S]*?)\}'),
    (match) => '${match.group(1)}$routeConstant}',
  );

  file.writeAsStringSync(updatedContent);
  print('Added $pageName route to $routePathsFile');
}

// Helper function to convert a string to camelCase
String _toCamelCase(String input) {
  // Clean the input: remove non-alphanumeric characters and normalize spaces
  final cleanedInput = input.replaceAll(RegExp(r'[^a-zA-Z0-9]'), ' ');

  // Split the input into words using a regex to detect word boundaries
  final words = cleanedInput.split(RegExp(r'(?=[A-Z])|[\s+]')).where((word) => word.isNotEmpty).toList();

  // Convert the words into camelCase
  final firstWord = words[0].toLowerCase();
  final remainingWords =
      words.sublist(1).map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase()).join('');

  return firstWord + remainingWords;
}
