// Function to add string to .arb files
import 'dart:convert';
import 'dart:io';

import 'package:ajmancli/utils/text_utils.dart';

void addStringToArbFiles(String value, String? arabic) {
  final currentDirectory = Directory.current.path;

  // Ensure the command is run from the root directory (ajman_flutter)
  if (!currentDirectory.endsWith('ajman_flutter')) {
    print('This command must be run in the "ajman_flutter" folder.');
    return;
  }

  // Generate camelCase key from the value
  final key = TextUtils.formatAsCamelCase(value);

  // Define the files to update
  final files = {
    'lib/l10n/intl_ar.arb': arabic ?? value, // Use Arabic string if provided
    'lib/l10n/intl_en.arb': value, // Use English string
  };

  bool keyExists = false;

  for (final entry in files.entries) {
    final filePath = entry.key;
    final stringValue = entry.value;

    final file = File(filePath);

    if (!file.existsSync()) {
      print('File not found: $filePath');
      continue;
    }

    try {
      // Read and parse the JSON content
      final content = file.readAsStringSync();
      final Map<String, dynamic> json = jsonDecode(content);

      // Check if the key already exists
      if (json.containsKey(key)) {
        keyExists = true;
        print('Key "$key" already exists in $filePath with value: "${json[key]}"');
        continue; // Skip adding the key
      }

      // Add the new string at the end
      json[key] = stringValue;

      // Write back to the file
      file.writeAsStringSync(JsonEncoder.withIndent('  ').convert(json));
      print('Added "$key": "$stringValue" to $filePath');
    } catch (e) {
      print('Failed to update $filePath: $e');
    }
  }
  if (!keyExists) {
    // Trigger the Flutter intl_utils:generate command if changes were made
    runFlutterIntlGenerate();
  }
}

void runFlutterIntlGenerate() async {
  try {
    final result = await Process.run(
      'flutter',
      ['--no-color', 'pub', 'global', 'run', 'intl_utils:generate'],
      runInShell: true,
    );
    if (result.exitCode == 0) {
      print('Generating intl files...');
      print(result.stdout);
    } else {
      print(
        'Command "flutter --no-color pub global run intl_utils:generate" failed with exit code ${result.exitCode}.',
      );
      print(result.stderr);
    }
  } catch (e) {
    print('Failed to execute "flutter --no-color pub global run intl_utils:generate": $e');
  }
}
