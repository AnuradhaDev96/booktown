abstract class ServiceEndpoints {
  /// Active base url for http requests. Start the suffix part without /
  static String get
  baseUrl => AppFlavour.production.baseUrl;
}

enum AppFlavour {
  production(baseUrl: 'https://api.itbook.store/1.0/');

  final String baseUrl;

  const AppFlavour({required this.baseUrl});
}
