import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:footsapp/common_ui/color_theme.dart';
import 'package:footsapp/common_ui/style_constants.dart';
import 'package:footsapp/core/enums/viewstate.dart';
import 'package:footsapp/core/utils/images.dart';
import 'package:footsapp/core/utils/screen_aware_size.dart';
import 'package:footsapp/core/view_models/user_auth_viewmodel.dart';
import 'package:footsapp/features/auth_user/screens/first_profile_setup_screen.dart';
import 'package:footsapp/features/auth_user/screens/non_social_login_screen.dart';
import 'package:footsapp/features/auth_user/screens/non_social_reg_screen.dart';
import 'package:footsapp/features/auth_user/widgets/social_sign_in_buttons.dart';
import 'package:provider/provider.dart';

class SocialLoginRegScreen extends StatefulWidget {
  static const String SCREEN_ID = 'social_login_screen';

  @override
  _SocialLoginRegScreenState createState() => _SocialLoginRegScreenState();
}

class _SocialLoginRegScreenState extends State<SocialLoginRegScreen> {
  ScreenAwareSize sw;

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

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      backgroundColor: FOOTSAPP_THEME_NAVY,
      body: SafeArea(
        child: Consumer<UserAuthViewModel>(
          builder: (context, viewModel, child) => Container(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: sw.sHeight(100),
                  ),
                  Image.asset(
                    '${Images.assetImagesPath}/footsapp-logo-light.png',
                    height: sw.sHeight(63),
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    height: sw.sHeight(75),
                  ),
                  Text(
                    'Get started with an amazing journey towards\n your ultimate social footballing experience',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'D-Din',
                      fontSize: sw.sHeight(17),
                    ),
                  ),
                  SizedBox(
                    height: sw.sHeight(16),
                  ),
                  SocialSignInButtons(
                    onPressed: () async {
                      final _authResponse =
                          await viewModel.completeFacebookLoginProcess();
                      if (_authResponse.success == true) {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            FirstProfileSetupScreen.SCREEN_ID,
                            (route) => false,
                          );
                        });
                      }
                    },
                    text: 'Facebook',
                    fontSize: sw.sHeight(16),
                    textColor: Colors.white,
                    backgroundColor: Color(0xFF38579A),
                    image: Image(
                      image: AssetImage(
                        '${Images.assetImagesPath}/logos/fb_logo.png',
                      ),
                      height: sw.sHeight(24),
                    ),
                    height: sw.sHeight(50),
                  ),
                  SizedBox(
                    height: sw.sHeight(16),
                  ),
                  SocialSignInButtons(
                    onPressed: () {
                      viewModel.completeGoogleSignInProcess();
                    },
                    text: 'Google',
                    fontSize: sw.sHeight(16),
                    textColor: Color(0xFF4A442A),
                    backgroundColor: Color(0xFFFFFFFF),
                    image: Image(
                      image: AssetImage(
                        '${Images.assetImageLogosPath}/google_light.png',
                      ),
                      height: sw.sHeight(24),
                    ),
                    height: sw.sHeight(50),
                  ),
                  SizedBox(
                    height: sw.sHeight(16),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, NonSocialRegScreen.SCREEN_ID);
                        },
                        child: Text(
                          'Non-Social Registration',
                          style: kWhiteTextStyleNormal.copyWith(
                              fontSize: sw.sHeight(16)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: sw.sWidth(8)),
                        width: 1,
                        height: sw.sHeight(16),
                        color: Colors.white,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, NonSocialLoginScreen.SCREEN_ID);
                        },
                        child: Text(
                          'Already Registered',
                          style: kWhiteTextStyleNormal.copyWith(
                              fontSize: sw.sHeight(16)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: sw.sHeight(16),
                  ),
                  viewModel.state == ViewState.Loading
                      ? CircularProgressIndicator()
                      : Container(),
                  viewModel.state == ViewState.Error
                      ? Text(
                          viewModel.errorMessage,
                          style: kErrorTextStyle,
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
