import 'dart:io';
import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:path/path.dart' as path;

abstract class CommonUtils {
  static Pubspec? pubSpec() {
    try {
      // Get the path of the script being executed
      final scriptPath = Platform.script.toFilePath();
      final packageRoot = path.dirname(path.dirname(scriptPath)); // Adjust based on your structure
      final pubspecPath = path.join(packageRoot, 'pubspec.yaml');

      final pubspec = File(pubspecPath).readAsStringSync();
      final parsed = Pubspec.parse(pubspec);
      return parsed;
    } catch (e) {
      print('Error reading pubspec.yaml | $e');
    }
    return null;
  }
}
