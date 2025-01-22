import 'dart:io';

import 'package:ajmancli/utils/text_utils.dart';

import './templates/page_template.dart';
import './templates/page_view_template.dart';
import './templates/page_view_model_template.dart';

void generatePage(String name) {
  final folderName = TextUtils.toSnakeCase(name);
  final folder = Directory(folderName);

  if (!folder.existsSync()) {
    folder.createSync();
  }

  final files = {
    '${folderName}_page.dart': pageTemplate(name),
    '${folderName}_page_view.dart': pageViewTemplate(name),
    '${folderName}_page_view_model.dart': pageViewModelTemplate(name),
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
