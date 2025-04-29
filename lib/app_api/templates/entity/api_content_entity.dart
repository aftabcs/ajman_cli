import 'package:ajmancli/utils/text_utils.dart';

String apiContentEntity({required String apiName, String? list, required String feature}) {
  if (list != null) {
    return '''

import 'package:data/entity/remote/$feature/${TextUtils.toSnakeCase(apiName)}/${TextUtils.toSnakeCase(list)}_entity.dart';
import 'package:domain/model/$feature/${TextUtils.toSnakeCase(apiName)}/${TextUtils.toSnakeCase(list)}.dart';
import 'package:domain/model/$feature/${TextUtils.toSnakeCase(apiName)}/${TextUtils.toSnakeCase(apiName)}_content.dart';

import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part '${TextUtils.toSnakeCase(apiName)}_content_entity.g.dart';

@JsonSerializable()
class ${apiName}ContentEntity
    extends BaseLayerDataTransformer<${apiName}ContentEntity, ${apiName}Content> {
  @JsonKey(name: "${TextUtils.toLowerCaseFirstLetter(list)}")
  final List<${list}Entity>? ${TextUtils.toLowerCaseFirstLetter(list)};



  ${apiName}ContentEntity({
    this.${TextUtils.toLowerCaseFirstLetter(list)},
  });

  @override
  ${apiName}Content transform() {
    List<$list> list = [];
    for (${list}Entity e in ${TextUtils.toLowerCaseFirstLetter(list)} ?? []) {
      list.add(e.transform());
    }
    return ${apiName}Content(${TextUtils.toLowerCaseFirstLetter(list)}: list);
  }

  factory ${apiName}ContentEntity.fromJson(Map<String, dynamic> json) =>
      _\$${apiName}ContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _\$${apiName}ContentEntityToJson(this);
}


''';
  }

  return '''

import 'package:domain/model/$feature/${TextUtils.toSnakeCase(apiName)}/${TextUtils.toSnakeCase(apiName)}_content.dart';

import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part '${TextUtils.toSnakeCase(apiName)}_content_entity.g.dart';

@JsonSerializable()
class ${apiName}ContentEntity
    extends BaseLayerDataTransformer<${apiName}ContentEntity, ${apiName}Content> {
  @JsonKey(name: "temp")
  final String? temp;

  ${apiName}ContentEntity({
    this.temp,
  });

  @override
  ${apiName}Content transform() { 
    return ${apiName}Content(
      temp: temp,
    );
  }

  factory ${apiName}ContentEntity.fromJson(Map<String, dynamic> json) =>
      _\$${apiName}ContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _\$${apiName}ContentEntityToJson(this);
}
''';
}
