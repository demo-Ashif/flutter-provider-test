import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:footsapp/common_ui/color_theme.dart';
import 'package:footsapp/common_ui/common_widgets/bordered_textfield_widget.dart';
import 'package:footsapp/common_ui/common_widgets/lined_textfield_widget.dart';
import 'package:footsapp/common_ui/style_constants.dart';
import 'package:footsapp/core/constants/pref_constants.dart';
import 'package:footsapp/core/di/injection_container.dart';
import 'package:footsapp/core/utils/images.dart';
import 'package:footsapp/core/utils/screen_aware_size.dart';
import 'package:footsapp/core/utils/shared_pref_util.dart';
import 'package:footsapp/core/view_models/user_profile_viewmodel.dart';
import 'package:footsapp/features/auth_user/screens/second_profile_setup_screen.dart';
import 'package:provider/provider.dart';

class FirstProfileSetupScreen extends StatefulWidget {
  static const String SCREEN_ID = 'first_profile_setup_screen';

  @override
  _FirstProfileSetupScreenState createState() =>
      _FirstProfileSetupScreenState();
}

class _FirstProfileSetupScreenState extends State<FirstProfileSetupScreen>
    with AfterLayoutMixin<FirstProfileSetupScreen> {
  ScreenAwareSize sw;
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  File _image;

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
  void afterFirstLayout(BuildContext context) {
    final prefs = sl<SharedPrefUtil>();

    _firstNameController.text = prefs.readString(FIRST_NAME);
    _lastNameController.text = prefs.readString(LAST_NAME);
    _emailController.text = prefs.readString(EMAIL);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FOOTSAPP_THEME_NAVY,
      body: SafeArea(
        child: Consumer<UserProfileViewModel>(
          builder: (context, viewModel, child) => Container(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: sw.sHeight(16),
                          ),
                          Image.asset(
                            '${Images.assetImagesPath}/footsapp-logo-light.png',
                            height: sw.sHeight(36),
                            fit: BoxFit.contain,
                          ),
                          SizedBox(
                            height: sw.sHeight(15),
                          ),
                          Text(
                            'Hi',
                            style: kGreenTextStyleBold.copyWith(
                                fontSize: sw.sHeight(26)),
                          ),
                          Form(
                            key: _formKey1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              //crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  //height: sw.sHeight(55),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: sw.sWidth(75.0),
                                    ),
                                    child: LinedTextField(
                                      controller: _firstNameController,
                                      hintText: 'your first name here',
                                      isPhone: false,
                                      textInputType: TextInputType.text,
                                      validator: viewModel.validateFirstName,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: sw.sHeight(8),
                                ),
                                Container(
                                  //height: sw.sHeight(55),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: sw.sWidth(75.0),
                                    ),
                                    child: LinedTextField(
                                      controller: _lastNameController,
                                      hintText: 'your last name here',
                                      isPhone: false,
                                      textInputType: TextInputType.text,
                                      validator: viewModel.validateLastName,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: sw.sHeight(24),
                          ),
                          Container(
                            height: sw.sHeight(90),
                            width: sw.sWidth(90),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              shape: BoxShape.circle,
                              border: Border.all(color: FOOTSAPP_THEME_GREEN),
                              image: _image == null
                                  ? null
                                  : DecorationImage(
                                      image: FileImage(_image),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            child: GestureDetector(
                              onTap: () => viewModel.getImage(),
                              child: Center(
                                child: AnimatedOpacity(
                                  duration: Duration(milliseconds: 375),
                                  opacity: _image == null ? 0.8 : 1.0,
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: sw.sHeight(24),
                          ),
                          Text(
                            'Let’s get you going!',
                            textAlign: TextAlign.center,
                            style: kGreenTextStyleBold.copyWith(
                              fontSize: sw.sHeight(19),
                            ),
                          ),
                          SizedBox(
                            height: sw.sHeight(16),
                          ),
                          Text(
                            'Please enter your email address  to link \nyour account to your unique identifier',
                            textAlign: TextAlign.center,
                            style: kWhiteTextStyleNormal.copyWith(
                              fontSize: sw.sHeight(17),
                            ),
                          ),
                          SizedBox(
                            height: sw.sHeight(16),
                          ),
                          Form(
                            key: _formKey2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              //crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  //height: sw.sHeight(55),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: sw.sWidth(45.0),
                                    ),
                                    child: BorderedTextField(
                                      controller: _emailController,
                                      hintText: 'Your Email',
                                      isPhone: false,
                                      labelText: 'Email',
                                      textInputType: TextInputType.emailAddress,
                                      validator: viewModel.validateEmail,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: sw.sHeight(16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: sw.sHeight(50),
                  padding: EdgeInsets.symmetric(horizontal: sw.sWidth(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: FOOTSAPP_THEME_NAVY,
                          size: sw.sHeight(28),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (_formKey1.currentState.validate() &&
                              _formKey2.currentState.validate()) {
                            _formKey1.currentState.save();
                            _formKey2.currentState.save();
                            final firstName = _firstNameController.text.trim();
                            final lastName = _lastNameController.text.trim();
                            final email = _emailController.text.trim();

                            viewModel.userProfile.firstName = firstName;
                            viewModel.userProfile.lastName = lastName;
                            viewModel.userProfile.email = email;

                            await Navigator.pushNamed(
                                context, SecondProfileSetupScreen.SCREEN_ID);
                          }
                        },
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: sw.sHeight(28),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
