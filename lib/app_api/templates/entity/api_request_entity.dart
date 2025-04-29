import 'package:ajmancli/utils/text_utils.dart';

String apiRequestEntity({required String apiName, required String feature}) {
  return '''

import 'package:json_annotation/json_annotation.dart';
part '${TextUtils.toSnakeCase(apiName)}_request_entity.g.dart';

@JsonSerializable()
class ${apiName}RequestEntity {
  final String? temp;

  ${apiName}RequestEntity({
    this.temp
  });

  factory ${apiName}RequestEntity.fromJson(Map<String, dynamic> json) =>
      _\$${apiName}RequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _\$${apiName}RequestEntityToJson(this);
}


  ''';
}
