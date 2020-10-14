import 'package:footsapp/core/constants/pref_constants.dart';
import 'package:footsapp/core/di/injection_container.dart';
import 'package:footsapp/core/utils/shared_pref_util.dart';

mixin TokenProvider {
  final sharedPrefUtil = sl<SharedPrefUtil>();

  Future<String> getToken() async {
    final String token = sharedPrefUtil.readString(ACCESS_TOKEN);
    return token;
  }

  Future setDetails({
    final String token,
    final int userId,
    final String name,
  }) async {
    await sharedPrefUtil.saveString(ACCESS_TOKEN, token);
    await sharedPrefUtil.saveString(FIRST_NAME, name);

    return await sharedPrefUtil.saveInt(USER_ID, userId);
  }

  Future<String> getName() async {
    return sharedPrefUtil.readString(FIRST_NAME);
  }

  Future<int> getId() async {
    return sharedPrefUtil.readInt(USER_ID);
  }

  Future setId(int id) async {
    assert(id != null, "User id cannot be null!");
    sharedPrefUtil.saveInt(USER_ID, id);
  }

  Future setName(String name) async {
    assert(name != null, "User name cannot be null!");
    sharedPrefUtil.saveString(FIRST_NAME, name);
  }

  Future logOut() async {
    await Future.wait(
      [
        sharedPrefUtil.remove(ACCESS_TOKEN),
        sharedPrefUtil.remove(FIRST_NAME),
        sharedPrefUtil.remove(USER_ID),
      ],
    );
  }

  Future saveToken(final String token) async {
    assert(token != null, "Token cannot be null!");
    sharedPrefUtil.saveString(ACCESS_TOKEN, token);
  }
}
