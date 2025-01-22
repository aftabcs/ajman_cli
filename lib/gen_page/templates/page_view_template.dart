import 'package:ajmancli/utils/text_utils.dart';

String pageViewTemplate(String name) {
  final className = '${name}PageView';
  return '''
import 'package:ajman/base/base_page.dart';
import 'package:flutter/material.dart';

import '${TextUtils.toSnakeCase(name)}_page_view_model.dart';

class $className extends BasePageViewWidget<${className}Model> {
  const $className(super.providerBase, {super.key});

  @override
  Widget build(BuildContext context, ${className}Model model) {
    return Placeholder();
  }
}
''';
}
