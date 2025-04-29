import 'package:ajmancli/utils/text_utils.dart';

String apiListValueEntity({
  required String listObjectName,
  required String featureName,
  required String apiName,
}) {
  return '''

import 'package:domain/model/$featureName/${TextUtils.toSnakeCase(apiName)}/${TextUtils.toSnakeCase(listObjectName)}.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part '${TextUtils.toSnakeCase(listObjectName)}_entity.g.dart';

@JsonSerializable()
class ${listObjectName}Entity extends BaseLayerDataTransformer<${listObjectName}Entity, $listObjectName> {
  final String? temp;

  ${listObjectName}Entity({
    this.temp,
  });

  factory ${listObjectName}Entity.fromJson(Map<String, dynamic> json) => _\$${listObjectName}EntityFromJson(json);

  Map<String, dynamic> toJson() => _\$${listObjectName}EntityToJson(this);

  @override
  $listObjectName transform() {
    return $listObjectName(
      temp: temp,
    );
  }
}


''';
}
