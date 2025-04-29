import 'package:ajmancli/utils/text_utils.dart';

String apiModel(String apiName) {
  return '''
import 'package:domain/model/status_model.dart';
import '${TextUtils.toSnakeCase(apiName)}_content.dart';

class $apiName {
  final ${apiName}Content? content;
  final StatusModel? statusModel;
  final String? requestDateTime;
  final String? logId;

  $apiName({
    this.content,
    this.statusModel,
    this.requestDateTime,
    this.logId,
  });
}

''';
}
