import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:footsapp/core/base/base_api/base_api_provider.dart';
import 'package:footsapp/data/models/auth_response.dart';
import 'package:footsapp/data/models/user_data_response.dart';

import 'login_reg_api.dart';

class LoginRegApiImpl extends BaseApiProvider implements LoginRegApi {
  //endpoints
  final facebookLoginEndpoint = 'login/facebook/';
  final googleSignInEndpoint = 'login/google/';
  final nonSocialSignUpEndpoint = 'signup/';
  final nonSocialLoginEndpoint = 'login/local';

  @override
  Future<UserDataResponse> getUserProfileInfo() async {
    final endpoint = "/user";
    final _client = await getClient();
    final response = await _client.get(endpoint);
    final statusCode = response.statusCode;

    if (statusCode != 200) {
      print("Failed to get user details! Status Code: $statusCode");
      return null;
    } else {
      final json = response.data;
      final user = UserDataResponse.fromJson(json["data"]);
      return user;
    }
  }

  @override
  Future<AuthResponse> postFacebookSocialLogin(String accessToken) async {
    final client = await getHeaderLessClient();

    try {
      final response = await client.post(
        facebookLoginEndpoint,
        options: Options(
          headers: socialAuthHeader(accessToken),
        ),
      );
      return AuthResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      debugPrint("Exception occurred: $error stackTrace: $stacktrace");
      return AuthResponse.withError(handleError(error));
    }
  }

  @override
  Future<AuthResponse> postGoogleSocialLogin(String accessToken) async {
    final client = await getHeaderLessClient();

    try {
      final response = await client.post(
        googleSignInEndpoint,
        options: Options(
          headers: socialAuthHeader(accessToken),
        ),
      );
      return AuthResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      debugPrint("Exception occurred: $error stackTrace: $stacktrace");
      return AuthResponse.withError(handleError(error));
    }
  }

  @override
  Future<AuthResponse> postNonSocialLogin(String email, String password) async {
    final client = await getHeaderLessClient();

    final data = jsonEncode(<String, String>{
      'email': email,
      'password': password,
    });

    var response;

    try {
      response = await client.post(
        nonSocialLoginEndpoint,
        data: data,
      );
      return AuthResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      debugPrint("Exception occurred: $error stackTrace: $stacktrace");
      return AuthResponse.withError(handleError(error));
    }
  }

  @override
  Future<AuthResponse> postNonSocialSignUp(
      String email, String password) async {
    final client = await getHeaderLessClient();

    final data = jsonEncode(<String, String>{
      'email': email,
      'password': password,
    });

    try {
      final response = await client.post(
        nonSocialSignUpEndpoint,
        data: data,
      );
      return AuthResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      debugPrint("Exception occurred: $error stackTrace: $stacktrace");
      return AuthResponse.withError(handleError(error));
    }
  }

//temporary getMySellRequestStatus
//  Future<StatusModel> getMySellRequestStatus({String accessToken}) async {
//    try {
//      String jsonString =
//          await rootBundle.loadString('assets/raw/all_status_response.json');
//      final jsonResponse = json.decode(jsonString);
//      return StatusModel.fromJson(jsonResponse);
//    } catch (error, stacktrace) {
//      debugPrint("Exception occurred: $error stackTrace: $stacktrace");
//      return StatusModel.withError(handleError(error));
//    }
//  }

//proper impl
// Future<GenericResponse> updatePlayerStatus(
//     int gameId, int playerId, int playerStatus) async {
//   final endpoint = "/game/$gameId/editRequests";
//   final client = await getClient();
//
//   final data = {"userId": playerId, "status": playerStatus};
//

//   try {
//     final response = await client.post(endpoint, data: data);
//     return GenericResponse.fromJson(response.data);
//   } catch (error, stacktrace) {
//     debugPrint("Exception occurred: $error stackTrace: $stacktrace");
//     return GenericResponse.withError(handleError(error));
//   }
// }

}
