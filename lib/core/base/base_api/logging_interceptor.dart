import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptors extends InterceptorsWrapper {
  Dio _dio;

  LoggingInterceptors(this._dio);

  int maxCharactersPerLine = 200;

  @override
  Future onRequest(RequestOptions options) {
    debugPrint("--> ${options.method} ${options.baseUrl}${options.path}");
    debugPrint("Content type: ${options.contentType}");
    debugPrint("Headers:");
    options.headers?.forEach((k, v) => debugPrint('$k: $v'));
    debugPrint("<-- END HTTP");
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    debugPrint(
        "<-- ${response.statusCode} ${response.request.method} ${response.request.path}");
    String responseAsString = response.data.toString();
    if (responseAsString.length > maxCharactersPerLine) {
      int iterations = (responseAsString.length / maxCharactersPerLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
        debugPrint(
            responseAsString.substring(i * maxCharactersPerLine, endingIndex));
      }
    } else {
      debugPrint(response.data.toString());
    }
    debugPrint("<-- END HTTP");
    return super.onResponse(response);
  }

  @override
  Future onError(DioError dioError) async {
    debugPrint(
        "ERROR[${dioError?.response?.statusCode}] => PATH: ${dioError?.request?.path}");
    super.onError(dioError);
  }
}
