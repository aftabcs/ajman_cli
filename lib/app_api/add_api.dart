import 'package:ajmancli/app_api/generate_entities.dart';
import 'package:ajmancli/app_api/generate_models.dart';

void addApi(String name, String feature, String? list, bool genReqEnt) {
  generateModels(name, feature, list);
  generateEntities(name, feature, list, genReqEnt);
}

/*
  This function generates API models and entities based on the provided parameters.
  It first generates the models using the generateModels function, and then generates the entities using the generateEntities function.
  The parameters are:
  - name: The name of the API.
  - feature: The feature to which the API belongs.
  - list: An optional parameter that specifies a list value.
  - genReqEnt: A boolean flag that indicates whether to generate request entities.
  - This flag determines if the request entity file should be created during the generation process.
  - If true, the request entity will be generated; otherwise, it will be skipped. 


  Example usage:
  ajmanlc addapi -n HelloAgainBro -f finance_onboarding -l HelloAgainBroList -r

*/
