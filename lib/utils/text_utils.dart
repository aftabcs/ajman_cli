abstract class TextUtils {
  static String toSnakeCase(String input) {
    return input.replaceAllMapped(RegExp(r'[A-Z]'), (match) {
      return '_${match.group(0)!.toLowerCase()}';
    }).replaceFirst('_', '');
  }

  static String toLowerCaseFirstLetter(String input) {
    if (input.isEmpty) return input; // Return empty string if input is empty
    return input[0].toLowerCase() + input.substring(1);
  }
}
