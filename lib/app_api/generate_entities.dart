import 'dart:io';

import 'package:ajmancli/app_api/templates/entity/api_content_entity.dart';
import 'package:ajmancli/app_api/templates/entity/api_list_value_entity.dart';
import 'package:ajmancli/app_api/templates/entity/api_request_entity.dart';
import 'package:ajmancli/app_api/templates/entity/api_response_entity.dart';
import 'package:ajmancli/utils/text_utils.dart';

void generateEntities(String name, String feature, String? list, bool genReqEnt) {
  // Convert name to snake_case for folder naming
  final folderName = TextUtils.toSnakeCase(name);

  // Define the base feature folder path: domain/lib/model/feature
  final featureFolder = Directory('data/lib/entity/remote/$feature');

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
    '${folderName}_response_entity.dart': apiResponseEntity(apiName: name, feature: feature),
    '${folderName}_content_entity.dart': apiContentEntity(apiName: name, list: list, feature: feature),
    if (genReqEnt) '${folderName}_request_entity.dart': apiRequestEntity(apiName: name, feature: feature),
    '${folderName}_request_entity.dart': apiRequestEntity(apiName: name, feature: feature),
    if (list != null)
      '${TextUtils.toSnakeCase(list)}_entity.dart': apiListValueEntity(
        listObjectName: list,
        featureName: feature,
        apiName: name,
      ),
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
