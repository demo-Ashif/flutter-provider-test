import 'package:footsapp/data/models/user_data_response.dart';

abstract class ProfileManageApi {
  Future<UserDataResponse> postUserProfileUpdate(final data);

  Future<UserDataResponse> getUserProfileInfo();
}
