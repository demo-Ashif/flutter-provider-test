import 'package:footsapp/data/models/user_data_response.dart';

abstract class ProfileManageRepo {
  Future<UserDataResponse> postUserProfileUpdate(final data);

  Future<UserDataResponse> getUserProfileInfo();
}
