import 'dart:io';

import 'package:ajmancli/app_api/templates/model/api_content_model.dart';
import 'package:ajmancli/app_api/templates/model/api_list_value_model.dart';
import 'package:ajmancli/app_api/templates/model/api_model.dart';
import 'package:ajmancli/utils/text_utils.dart';

void generateModels(String name, String feature, String? list) {
  // Convert name to snake_case for folder naming
  final folderName = TextUtils.toSnakeCase(name);

  // Define the base feature folder path: domain/lib/model/feature
  final featureFolder = Directory('domain/lib/model/$feature');

  // Create feature folder if it doesn't exist
  if (!featureFolder.existsSync()) {
    featureFolder.createSync(recursive: true);
    print('Created feature folder: ${featureFolder.path}');
  }

  // Define the API folder path: domain/lib/model/feature/folderName
  final apiFolder = Directory('${featureFolder.path}/$folderName');

  // Create API folder if it doesn't exist
  if (!apiFolder.existsSync()) {
    apiFolder.createSync();
    print('Created API folder: ${apiFolder.path}');
  }

  // Define the files to generate
  final files = {
    '$folderName.dart': apiModel(name),
    '${folderName}_content.dart': apiContentModel(name, list),
    if (list != null) '${TextUtils.toSnakeCase(list)}.dart': apiListValueModel(list),
  };

  // Generate files
  files.forEach((fileName, content) {
    final file = File('${apiFolder.path}/$fileName');
    if (!file.existsSync()) {
      file.writeAsStringSync(content);
      print('Created: ${file.path}');
    } else {
      print('Skipped (already exists): ${file.path}');
    }
  });

  print('✅ Files generated successfully in ${apiFolder.path}');
  // addToRoutePaths(name); // Uncomment if you want to keep this
}
