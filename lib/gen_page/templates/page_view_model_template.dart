import 'package:ajmancli/utils/text_utils.dart';

String pageViewModelTemplate(String name, bool addArgs) {
  final className = '${name}PageViewModel';
  return addArgs
      ? '''
import 'package:ajman/base/base_page_view_model.dart';

import '${TextUtils.toSnakeCase(name)}_page.dart';

class $className extends BasePageViewModel {
  $className();
  ${name}PageArgs? args;


  @override
  void dispose() {
    super.dispose();
  }
}
'''
      : '''
import 'package:ajman/base/base_page_view_model.dart';


class $className extends BasePageViewModel {
  $className();


  @override
  void dispose() {
    super.dispose();
  }
}
''';
}
