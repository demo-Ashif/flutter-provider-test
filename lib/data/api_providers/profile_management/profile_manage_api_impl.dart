import 'package:flutter/foundation.dart';
import 'package:footsapp/core/base/base_api/base_api_provider.dart';
import 'package:footsapp/data/models/user_data_response.dart';

import 'profile_manage_api.dart';

class ProfileManageApiImpl extends BaseApiProvider implements ProfileManageApi {
  //endpoints
  final profileUpdateEndpoint = 'profile/update';
  final getUserEndpoint = 'profile/';

  @override
  Future<UserDataResponse> getUserProfileInfo() async {
    final client = await getClient();

    try {
      final response = await client.get(
        getUserEndpoint,
      );
      return UserDataResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      debugPrint("Exception occurred: $error stackTrace: $stacktrace");
      return UserDataResponse.withError(handleError(error));
    }
  }

  @override
  Future<UserDataResponse> postUserProfileUpdate(data) async {
    final client = await getClient();

    try {
      final response = await client.put(
        profileUpdateEndpoint,
        data: data,
      );
      return UserDataResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      debugPrint("Exception occurred: $error stackTrace: $stacktrace");
      return UserDataResponse.withError(handleError(error));
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
