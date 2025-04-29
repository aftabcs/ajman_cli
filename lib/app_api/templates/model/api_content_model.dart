import 'package:ajmancli/utils/text_utils.dart';

String apiContentModel(String apiName, String? list) {
  if (list != null) {
    return '''

import '${TextUtils.toSnakeCase(list)}.dart';

class ${apiName}Content {
  final String? temp;
  final List<$list>? ${TextUtils.toLowerCaseFirstLetter(list)};

  ${apiName}Content({
    this.temp,
    this.${TextUtils.toLowerCaseFirstLetter(list)},
  });
}

''';
  }

  return '''

class ${apiName}Content {
  final String? temp;

  ${apiName}Content({
    this.temp,
  });
}

''';
}
