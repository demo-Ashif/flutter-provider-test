import 'dart:io';

mixin AuthHeaderProvider {
  Map<String, String> createAuthHeader(final String token) {
    return {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
  }

  Map<String, String> socialAuthHeader(final String token) {
    return {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
  }
}
