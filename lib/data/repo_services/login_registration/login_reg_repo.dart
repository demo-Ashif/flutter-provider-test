import 'package:footsapp/data/models/auth_response.dart';
import 'package:footsapp/data/models/user_data_response.dart';

abstract class LoginRegRepo {
  Future<AuthResponse> postGoogleSocialLogin(String accessToken);

  Future<AuthResponse> postFacebookSocialLogin(String accessToken);

  Future<UserDataResponse> getUserProfileInfo();

  Future<AuthResponse> postNonSocialSignUp(String email, String password);

  Future<AuthResponse> postNonSocialLogin(String email, String password);
}
