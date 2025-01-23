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

  static String formatAsCamelCase(String input) {
    final cleanedInput = input.replaceAll(RegExp(r'[^a-zA-Z0-9\s]'), '').replaceAll(RegExp(r'\s+'), ' ');
    final words = cleanedInput.split(' ');
    final firstWord = words[0].toLowerCase();
    final remainingWords =
        words.sublist(1).map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase());
    return firstWord + remainingWords.join('');
  }
}
