import 'package:footsapp/data/models/auth_response.dart';
import 'package:footsapp/data/models/user_data_response.dart';

abstract class LoginRegStorage {
  Future<AuthResponse> postSocialLogin();

  Future<UserDataResponse> getUserProfileInfo();
}
