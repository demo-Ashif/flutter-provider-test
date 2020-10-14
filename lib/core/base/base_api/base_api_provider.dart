import 'dart:io';

import 'package:dio/dio.dart';
import 'package:footsapp/core/base/base_api/token_provider.dart';

import 'header_provider.dart';
import 'logging_interceptor.dart';

abstract class BaseApiProvider with TokenProvider, AuthHeaderProvider {
  static const modeDevelopment = true;

  static const baseUrl = modeDevelopment == true
      ? "https://v2.footsapp.com/"
      : "https://api.footsapp.com/v1";

  final Dio _client = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 30000,
      receiveTimeout: 60000,
    ),
  );

  Future<Dio> getHeaderLessClient() async {
    _client
      ..interceptors.add(
        LoggingInterceptors(_client),
      );

    return _client;
  }

  Future<Dio> getClient() async {
    _client
      ..interceptors.add(
        LoggingInterceptors(_client),
      );

    final token = await getToken();
    //debugPrint('$token');
    final _authInterceptor = InterceptorsWrapper(
      onRequest: (RequestOptions requestOptions) async {
        final Map<String, dynamic> headers = {
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token",
        };
        requestOptions.headers.addAll(headers);
        return requestOptions;
      },
    );

    if (!_client.interceptors.contains(_authInterceptor)) {
      _client..interceptors.add(_authInterceptor);
    }

    return _client;
  }

  String handleError(DioError error) {
    String errorDescription = "";

    switch (error.type) {
      case DioErrorType.CANCEL:
        errorDescription = "Request to API server was cancelled";
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        errorDescription = "Connection timeout with API server";
        break;
      case DioErrorType.DEFAULT:
        errorDescription =
            "Connection to API server failed due to internet connection";
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        errorDescription = "Receive timeout in connection with API server";
        break;
      case DioErrorType.RESPONSE:
        errorDescription =
            "Received invalid status code: ${error.response.statusCode}";
        break;
      case DioErrorType.SEND_TIMEOUT:
        errorDescription = "Send timeout in connection with API server";
        break;
    }

    return errorDescription;
  }
}
