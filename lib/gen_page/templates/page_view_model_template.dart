String pageViewModelTemplate(String name) {
  final className = '${name}PageViewModel';
  return '''
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
