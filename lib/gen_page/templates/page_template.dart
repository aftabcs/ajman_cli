import 'package:ajmancli/utils/text_utils.dart';

String pageTemplate(String name, bool addArgs) {
  final className = '${name}Page';
  return addArgs
      ? '''
import 'package:ajman/base/base_page.dart';
import 'package:ajman/generated/l10n.dart';
import 'package:ajman/ui/molecules/app_bar_with_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '${TextUtils.toSnakeCase(name)}_page_view_model.dart';
import '${TextUtils.toSnakeCase(name)}_page_view.dart';

class $className extends BasePage<${className}ViewModel> {
  const $className({super.key,this.args});

  final ${className}Args? args;

  @override
  State<StatefulWidget> createState() => ${className}State();
}

class ${className}State extends BaseStatefulPage<${className}ViewModel, $className> {
  @override
  Widget buildView(BuildContext context, ${className}ViewModel model) {
    return ${className}View(
      provideBase(),
    );
  }

  @override
  PreferredSizeWidget? buildAppbar() {
    return appBarWithProgress(
      wantProgress: true,
      wantLeadingBackButton: true,
      wantCrossButton: false,
      title: Text(S.of(context).name),
      progress: 50,
    );
  }

  @override
  void didChangeDependencies() {
    final ${className}ViewModel model =
        ProviderScope.containerOf(context).read(${TextUtils.toLowerCaseFirstLetter(className)}ViewModelProvider);
    model.args = widget.args;
    super.didChangeDependencies();
  }

  @override
  ProviderBase provideBase() => ${TextUtils.toLowerCaseFirstLetter(className)}ViewModelProvider;
}

class ${className}Args {
  ${className}Args();
}


var ${TextUtils.toLowerCaseFirstLetter(className)}ViewModelProvider =
    ChangeNotifierProvider.autoDispose<${className}ViewModel>(
        (ref) => ${className}ViewModel());

'''
      : '''
import 'package:ajman/base/base_page.dart';
import 'package:ajman/generated/l10n.dart';
import 'package:ajman/ui/molecules/app_bar_with_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '${TextUtils.toSnakeCase(name)}_page_view_model.dart';
import '${TextUtils.toSnakeCase(name)}_page_view.dart';

class $className extends BasePage<${className}ViewModel> {
  const $className({super.key});

  @override
  State<StatefulWidget> createState() => ${className}State();
}

class ${className}State extends BaseStatefulPage<${className}ViewModel, $className> {
  @override
  Widget buildView(BuildContext context, ${className}ViewModel model) {
    return ${className}View(
      provideBase(),
    );
  }

  @override
  PreferredSizeWidget? buildAppbar() {
    return appBarWithProgress(
      wantProgress: true,
      wantLeadingBackButton: true,
      wantCrossButton: false,
      title: Text(S.of(context).name),
      progress: 50,
    );
  }

  @override
  void didChangeDependencies() {
    final ${className}ViewModel model =
        ProviderScope.containerOf(context).read(${TextUtils.toLowerCaseFirstLetter(className)}ViewModelProvider);
    super.didChangeDependencies();
  }

  @override
  ProviderBase provideBase() => ${TextUtils.toLowerCaseFirstLetter(className)}ViewModelProvider;
}


var ${TextUtils.toLowerCaseFirstLetter(className)}ViewModelProvider =
    ChangeNotifierProvider.autoDispose<${className}ViewModel>(
        (ref) => ${className}ViewModel());

''';
}
