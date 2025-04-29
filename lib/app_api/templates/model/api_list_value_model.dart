String apiListValueModel(String listObjectName) {
  return '''

class $listObjectName {
  final String? temp;

  $listObjectName({
    this.temp,
  });
}

''';
}
