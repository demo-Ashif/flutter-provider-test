import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:footsapp/common_ui/common_widgets/footsapp_circular_loader.dart';
import 'package:footsapp/core/base/base_api/token_provider.dart';
import 'package:footsapp/core/constants/pref_constants.dart';
import 'package:footsapp/core/di/injection_container.dart';
import 'package:footsapp/core/utils/images.dart';
import 'package:footsapp/core/utils/screen_aware_size.dart';
import 'package:footsapp/core/utils/shared_pref_util.dart';
import 'package:footsapp/core/view_models/user_profile_viewmodel.dart';
import 'package:footsapp/features/auth_user/screens/first_profile_setup_screen.dart';
import 'package:footsapp/features/auth_user/screens/social_login_reg_screen.dart';
import 'package:footsapp/features/bottom_nav_container/screens/bottom_nav_container.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../core/utils/screen_aware_size.dart';

class SplashView extends StatefulWidget {
  static const String SCREEN_ID = 'splash_view_screen';

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with TokenProvider, AfterLayoutMixin<SplashView> {
  ScreenAwareSize sw;
  final userProfileViewModel = sl<UserProfileViewModel>();
  final prefUtil = sl<SharedPrefUtil>();

  @override
  void afterFirstLayout(BuildContext context) {
    // prefUtil.saveBool(IS_LOGGED_IN, false);
    Future.delayed(Duration(seconds: 1), () async {
      bool isLoggedIn = prefUtil.readBool(IS_LOGGED_IN) ?? false;
      bool initialProfileUpdated =
          prefUtil.readBool(INITIAL_PROFILE_UPDATED) ?? false;
      isLoggedIn == true
          ? initialProfileUpdated == true
              ? getProfileInfo()
              : await Navigator.pushNamedAndRemoveUntil(
                  context,
                  FirstProfileSetupScreen.SCREEN_ID,
                  (route) => false,
                )
          : await Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => SocialLoginRegScreen(),
              ),
              (route) => false);
    });
  }

  @override
  void initState() {
    super.initState();
    // sw = ScreenAwareSize(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    sw ??= ScreenAwareSize(context);
  }

  void getProfileInfo() async {
    final userProfileResponse = await userProfileViewModel.getUserProfileData();

    if (userProfileResponse.success == true) {
      print('In splash: ${userProfileViewModel.userProfile.toString()}');
      Future.delayed(Duration(milliseconds: 1000), () async {
        await Navigator.pushReplacementNamed(
          context,
          BottomNavContainer.SCREEN_ID,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          top: false,
          bottom: false,
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Color(0xFF121212),
                child: FadeInImage(
                  image: AssetImage('${Images.assetImagesPath}/bg5.png'),
                  placeholder: MemoryImage(kTransparentImage),
                  fit: BoxFit.cover,
                  fadeInDuration: Duration(milliseconds: 80),
                  fadeOutDuration: Duration(milliseconds: 80),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: AnimationConfiguration.toStaggeredList(
                    childAnimationBuilder: (widget) => FadeInAnimation(
                      child: widget,
                      duration: Duration(milliseconds: 375),
                    ),
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: sw.sWidth(24),
                          vertical: sw.sHeight(18),
                        ),
                        child: Image.asset(
                          '${Images.assetImagesPath}/footsapp-logo-whitey.webp',
                          height: sw.sHeight(60),
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: sw.sHeight(28)),
                      FootsAppCircularLoader(),
                      SizedBox(height: sw.sHeight(58)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
