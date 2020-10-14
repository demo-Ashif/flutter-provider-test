import 'package:footsapp/core/di/injection_container.dart';
import 'package:footsapp/data/api_providers/login_registration/login_reg_api.dart';
import 'package:footsapp/data/models/auth_response.dart';
import 'package:footsapp/data/models/user_data_response.dart';

import 'login_reg_repo.dart';

class LoginRegRepoImpl implements LoginRegRepo {
  LoginRegApi _loginRegApi = sl<LoginRegApi>();

  @override
  Future<UserDataResponse> getUserProfileInfo() async {
    return _loginRegApi.getUserProfileInfo();
  }

  @override
  Future<AuthResponse> postGoogleSocialLogin(String accessToken) {
    return _loginRegApi.postGoogleSocialLogin(accessToken);
  }

  @override
  Future<AuthResponse> postFacebookSocialLogin(String accessToken) {
    return _loginRegApi.postFacebookSocialLogin(accessToken);
  }

  @override
  Future<AuthResponse> postNonSocialLogin(String email, String password) {
    return _loginRegApi.postNonSocialLogin(email, password);
  }

  @override
  Future<AuthResponse> postNonSocialSignUp(String email, String password) {
    return _loginRegApi.postNonSocialSignUp(email, password);
  }
}
