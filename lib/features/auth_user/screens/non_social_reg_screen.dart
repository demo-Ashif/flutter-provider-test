import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:footsapp/common_ui/color_theme.dart';
import 'package:footsapp/common_ui/common_widgets/bordered_textfield_widget.dart';
import 'package:footsapp/common_ui/common_widgets/filled_button.dart';
import 'package:footsapp/common_ui/style_constants.dart';
import 'package:footsapp/core/constants/pref_constants.dart';
import 'package:footsapp/core/di/injection_container.dart';
import 'package:footsapp/core/enums/viewstate.dart';
import 'package:footsapp/core/utils/images.dart';
import 'package:footsapp/core/utils/screen_aware_size.dart';
import 'package:footsapp/core/utils/shared_pref_util.dart';
import 'package:footsapp/core/view_models/user_auth_viewmodel.dart';
import 'package:footsapp/features/auth_user/screens/first_profile_setup_screen.dart';
import 'package:provider/provider.dart';

class NonSocialRegScreen extends StatefulWidget {
  static const String SCREEN_ID = 'non_social_reg_screen';

  @override
  _NonSocialRegScreenState createState() => _NonSocialRegScreenState();
}

class _NonSocialRegScreenState extends State<NonSocialRegScreen> {
  ScreenAwareSize sw;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

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
        child: Consumer<UserAuthViewModel>(
          builder: (context, viewModel, child) => Container(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
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
                    height: sw.sHeight(24),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          //height: sw.sHeight(85),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: sw.sWidth(45.0),
                            ),
                            child: BorderedTextField(
                              controller: _emailController,
                              hintText: 'Your Email',
                              labelText: 'Email',
                              isPhone: false,
                              textInputType: TextInputType.emailAddress,
                              validator: viewModel.validateEmail,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: sw.sHeight(16),
                        ),
                        Container(
                          //height: sw.sHeight(85),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: sw.sWidth(45.0),
                            ),
                            child: BorderedTextField(
                              controller: _passwordController,
                              hintText: 'Password',
                              labelText: 'Password',
                              isPhone: false,
                              textInputType: TextInputType.text,
                              obscureText: true,
                              validator: viewModel.validatePassword,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: sw.sHeight(16),
                  ),
                  viewModel.state == ViewState.Loading
                      ? CircularProgressIndicator()
                      : FilledButton(
                          onPressed: () async {
                            // CommonLoaderDialog.show(context, false, key: _keyLoader);
                            // Future.delayed(Duration(seconds: 2), () {
                            //   Navigator.of(_keyLoader.currentContext,
                            //           rootNavigator: true)
                            //       .pop();
                            // });

                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              final email = _emailController.text.trim();
                              final password = _passwordController.text.trim();

                              final _authResponse = await viewModel
                                  .completeNonSocialRegistrationProcess(
                                      email, password);

                              if (_authResponse.success == true) {
                                await sl<SharedPrefUtil>()
                                    .saveString(EMAIL, email);

                                SchedulerBinding.instance
                                    .addPostFrameCallback((_) {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    FirstProfileSetupScreen.SCREEN_ID,
                                    (route) => false,
                                  );
                                });
                              }
                            }
                          },
                          text: 'Sign Up',
                          textColor: FOOTSAPP_THEME_NAVY,
                          backgroundColor: FOOTSAPP_THEME_GREEN,
                        ),
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
