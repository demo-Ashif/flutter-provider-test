import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:footsapp/core/utils/shared_pref_util.dart';
import 'package:footsapp/core/view_models/bottom_nav_viewmodel.dart';
import 'package:footsapp/core/view_models/user_auth_viewmodel.dart';
import 'package:footsapp/core/view_models/user_profile_viewmodel.dart';
import 'package:footsapp/features/auth_user/screens/final_profile_setup_screen.dart';
import 'package:footsapp/features/auth_user/screens/first_profile_setup_screen.dart';
import 'package:footsapp/features/auth_user/screens/non_social_login_screen.dart';
import 'package:footsapp/features/auth_user/screens/non_social_reg_screen.dart';
import 'package:footsapp/features/auth_user/screens/second_profile_setup_screen.dart';
import 'package:footsapp/features/auth_user/screens/social_login_reg_screen.dart';
import 'package:footsapp/features/bottom_nav_container/screens/bottom_nav_container.dart';
import 'package:footsapp/features/user_profile/screens/edit_profile_screen.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

import 'core/constants/pref_constants.dart';
import 'core/di/injection_container.dart' as di;
import 'core/di/injection_container.dart';
import 'features/onboarding/screens/onboarding.dart';
import 'features/splash/screens/splashview.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Development();
}

class Development {
  Development() {
    _setupDebugPrint();
    _setupPrimarySystem();
    _init();
  }
}

void _setupPrimarySystem() async {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
}

void _setupDebugPrint() async {
  var packageInfo = await PackageInfo.fromPlatform();
  debugPrint = (String message, {int wrapWidth}) =>
      _debugPrintSynchronouslyWithText(message, packageInfo.version,
          wrapWidth: wrapWidth);
}

void _debugPrintSynchronouslyWithText(String message, String version,
    {int wrapWidth}) {
  message = "[${DateTime.now()} - $version]: $message";
  debugPrintSynchronously(message, wrapWidth: wrapWidth);
}

void _init() async {
  await di.init();
  await Firebase.initializeApp();

  bool isFirstLaunch = sl<SharedPrefUtil>().readBool(FIRST_APP_LAUNCH) ?? true;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserAuthViewModel>(
            create: (context) => sl<UserAuthViewModel>()),
        ChangeNotifierProvider<UserProfileViewModel>(
            create: (context) => sl<UserProfileViewModel>()),
        ChangeNotifierProvider<BottomNavViewModel>(
            create: (context) => sl<BottomNavViewModel>()),
      ],
      child: MaterialApp(
        title: "Footsapp",
        theme: ThemeData(fontFamily: 'Montserrat'),
        debugShowCheckedModeBanner: false,
        home: isFirstLaunch == true ? OnBoarding() : SplashView(),
        routes: {
          //onboarding
          SplashView.SCREEN_ID: (context) => SplashView(),

          //user auth
          SocialLoginRegScreen.SCREEN_ID: (context) => SplashView(),
          NonSocialRegScreen.SCREEN_ID: (context) => NonSocialRegScreen(),
          NonSocialLoginScreen.SCREEN_ID: (context) => NonSocialLoginScreen(),
          FirstProfileSetupScreen.SCREEN_ID: (context) =>
              FirstProfileSetupScreen(),
          SecondProfileSetupScreen.SCREEN_ID: (context) =>
              SecondProfileSetupScreen(),
          FinalProfileSetupScreen.SCREEN_ID: (context) =>
              FinalProfileSetupScreen(),

          //bottom nav pages
          BottomNavContainer.SCREEN_ID: (context) => BottomNavContainer(),

          //user profile
          EditProfileScreen.SCREEN_ID: (context) => EditProfileScreen(),
        },
      ),
    ),
  );
}
