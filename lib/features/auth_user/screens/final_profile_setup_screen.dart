import 'package:flutter/material.dart';
import 'package:footsapp/common_ui/color_theme.dart';
import 'package:footsapp/common_ui/style_constants.dart';
import 'package:footsapp/core/utils/images.dart';
import 'package:footsapp/core/utils/screen_aware_size.dart';
import 'package:footsapp/core/view_models/user_profile_viewmodel.dart';
import 'package:footsapp/features/auth_user/widgets/social_sign_in_buttons.dart';
import 'package:provider/provider.dart';

class FinalProfileSetupScreen extends StatefulWidget {
  static const String SCREEN_ID = 'final_profile_setup_screen';
  @override
  _FinalProfileSetupScreenState createState() =>
      _FinalProfileSetupScreenState();
}

class _FinalProfileSetupScreenState extends State<FinalProfileSetupScreen> {
  ScreenAwareSize sw;

  @override
  void initState() {
    super.initState();
    sw = ScreenAwareSize(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FOOTSAPP_THEME_NAVY,
      body: SafeArea(
        child: Consumer<UserProfileViewModel>(
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
                    onPressed: () {
                      //viewModel.handleFacebookLogin();
                    },
                    text: 'Facebook',
                    fontSize: sw.sHeight(16),
                    textColor: Colors.white,
                    backgroundColor: Color(0xFF38579A),
                    image: Image(
                      image: AssetImage(
                        'images/logos/fb_logo.png',
                      ),
                      height: sw.sHeight(24),
                    ),
                    height: sw.sHeight(50),
                  ),
                  SocialSignInButtons(
                    onPressed: () {
                      //viewModel.handleGoogleSignIn();
                    },
                    text: 'Google',
                    fontSize: sw.sHeight(16),
                    textColor: Color(0xFF4A442A),
                    backgroundColor: Color(0xFFFFFFFF),
                    image: Image(
                      image: AssetImage(
                        'images/logos/google_light.png',
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
                      Text(
                        'Non-Social Registration',
                        style: kWhiteTextStyleNormal.copyWith(
                            fontSize: sw.sHeight(16)),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: sw.sWidth(8)),
                        width: 1,
                        height: sw.sHeight(16),
                        color: Colors.white,
                      ),
                      Text(
                        'Already Registered',
                        style: kWhiteTextStyleNormal.copyWith(
                            fontSize: sw.sHeight(16)),
                      ),
                    ],
                  ),
                  // RaisedButton(
                  //   onPressed: () {
                  //     viewModel.googleSignOut();
                  //   },
                  //   child: Text('Sign Out Google'),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
