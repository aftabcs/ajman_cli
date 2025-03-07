import 'dart:io';
import 'package:pubspec_parse/pubspec_parse.dart';

abstract class CommonUtils {
  static Pubspec? pubSpec() {
    try {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final parsed = Pubspec.parse(pubspec);
      return parsed;
    } catch (e) {
      print('Error reading pubspec.yaml | $e');
    }
    return null;
  }
}
