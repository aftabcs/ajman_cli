import 'package:ajmancli/utils/text_utils.dart';

String apiResponseEntity({required String apiName, required String feature}) {
  return '''

import 'package:data/entity/remote/$feature/${TextUtils.toSnakeCase(apiName)}/${TextUtils.toSnakeCase(apiName)}_content_entity.dart';
import 'package:domain/model/$feature/${TextUtils.toSnakeCase(apiName)}/${TextUtils.toSnakeCase(apiName)}.dart';

import 'package:data/entity/remote/user/status/status_entity.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';


part '${TextUtils.toSnakeCase(apiName)}_response_entity.g.dart';

@JsonSerializable()
class ${apiName}ResponseEntity
    extends BaseLayerDataTransformer<${apiName}ResponseEntity, $apiName> {
  @JsonKey(name: "content")
  final Map<String, dynamic>? content;

  @JsonKey(name: "status")
  final Map<String, dynamic>? status;

  @JsonKey(name: "requestDateTime")
  final String? requestDateTime;

  @JsonKey(name: "logId")
  final String? logId;

  ${apiName}ResponseEntity({
    this.content,
    this.status,
    this.logId,
    this.requestDateTime,
  });

  factory ${apiName}ResponseEntity.fromJson(Map<String, dynamic> json) =>
      _\$${apiName}ResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _\$${apiName}ResponseEntityToJson(this);

  @override
  $apiName transform() {
    return $apiName(
      content: ${apiName}ContentEntity.fromJson(
        content ?? {},
      ).transform(),
      statusModel: StatusEntity.fromJson(
        status ?? {},
      ).transform(),
      requestDateTime: requestDateTime,
      logId: logId,
    );
  }
}


''';
}
