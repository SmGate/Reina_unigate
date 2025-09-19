class ServerException implements Exception {
  ServerException(this.message);
  String? message;
}

class GeneralException implements Exception {
  GeneralException(this.message);
  String? message;
}

class CacheException implements Exception {}
