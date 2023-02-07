class ApiException implements Exception {
  final String? msg;

  ApiException({this.msg});
}
