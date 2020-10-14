import 'package:footsapp/core/di/injection_container.dart';
import 'package:footsapp/data/api_providers/profile_management/profile_manage_api.dart';
import 'package:footsapp/data/models/user_data_response.dart';

import 'profile_manage_repo.dart';

class ProfileManageRepoImpl implements ProfileManageRepo {
  ProfileManageApi _profileManageApi = sl<ProfileManageApi>();

  @override
  Future<UserDataResponse> getUserProfileInfo() async {
    return _profileManageApi.getUserProfileInfo();
  }

  @override
  Future<UserDataResponse> postUserProfileUpdate(data) {
    return _profileManageApi.postUserProfileUpdate(data);
  }
}
