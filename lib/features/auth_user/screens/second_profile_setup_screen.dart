import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:footsapp/common_ui/color_theme.dart';
import 'package:footsapp/common_ui/common_widgets/common_loader_dialog.dart';
import 'package:footsapp/common_ui/style_constants.dart';
import 'package:footsapp/core/di/injection_container.dart';
import 'package:footsapp/core/utils/images.dart';
import 'package:footsapp/core/utils/screen_aware_size.dart';
import 'package:footsapp/core/view_models/user_profile_viewmodel.dart';
import 'package:footsapp/features/auth_user/widgets/preferred_position_widget.dart';
import 'package:footsapp/features/auth_user/widgets/segmented_control_pref_foot.dart';
import 'package:footsapp/features/bottom_nav_container/screens/bottom_nav_container.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/screen_aware_size.dart';

class SecondProfileSetupScreen extends StatefulWidget {
  static const String SCREEN_ID = 'second_profile_setup_screen';

  @override
  _SecondProfileSetupScreenState createState() =>
      _SecondProfileSetupScreenState();
}

class _SecondProfileSetupScreenState extends State<SecondProfileSetupScreen> {
  ScreenAwareSize sw;
  int _selectedIndex = 0;
  double _currentSliderValue = 3;

  var date;
  var dateText = 'Birthday';
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final profileViewModel = sl<UserProfileViewModel>();

  @override
  void initState() {
    super.initState();
    // sw = ScreenAwareSize(context);
    // profileViewModel.isShowLoading.listen((bool value) {
    //   print(value);
    //   if (value == true) {
    //     CommonLoaderDialog.show(context, false, key: _keyLoader);
    //   } else {
    //     Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
    //   }
    // });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    sw ??= ScreenAwareSize(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FOOTSAPP_THEME_NAVY,
      body: SafeArea(
        child: Consumer<UserProfileViewModel>(
          builder: (context, viewmodel, child) => Container(
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
                            height: sw.sHeight(24),
                          ),
                          Text(
                            'Tell us about you',
                            style: kGreenTextStyleBold.copyWith(
                                fontSize: sw.sHeight(24)),
                          ),
                          SizedBox(
                            height: sw.sHeight(16),
                          ),
                          Text(
                            'We’ll use personalized matching to recommend \nmatches and positions to you based on this info',
                            textAlign: TextAlign.center,
                            style: kWhiteTextStyleNormal.copyWith(
                              fontSize: sw.sHeight(17),
                            ),
                          ),
                          SizedBox(
                            height: sw.sHeight(16),
                          ),
                          Text(
                            'Preferred Foot',
                            textAlign: TextAlign.center,
                            style: kWhiteTextStyleNormal.copyWith(
                                fontSize: sw.sHeight(17),
                                fontFamily: 'Proxima-Nova'),
                          ),
                          SizedBox(
                            height: sw.sHeight(16),
                          ),
                          SegmentedControlPrefFoot(
                            segments: ["Left", "Right"],
                            onSegmentTap: (int index) {
                              setState(() {
                                _selectedIndex = index;
                              });
                              _selectedIndex == 0
                                  ? viewmodel.userProfile.preferredFoot = 'Left'
                                  : viewmodel.userProfile.preferredFoot =
                                      'Right';
                            },
                            selectedIndex: _selectedIndex,
                          ),
                          SizedBox(
                            height: sw.sHeight(16),
                          ),
                          Text(
                            'Preferred Position',
                            textAlign: TextAlign.center,
                            style: kWhiteTextStyleNormal.copyWith(
                                fontSize: sw.sHeight(17),
                                fontFamily: 'Proxima-Nova'),
                          ),
                          SizedBox(
                            height: sw.sHeight(16),
                          ),
                          PreferredPositionWidget(),
                          SizedBox(
                            height: sw.sHeight(16),
                          ),
                          Text(
                            'How many times a week do you play?',
                            textAlign: TextAlign.center,
                            style: kWhiteTextStyleNormal.copyWith(
                                fontSize: sw.sHeight(17),
                                fontFamily: 'Proxima-Nova'),
                          ),
                          Container(
                            width: sw.sWidth(300),
                            child: Slider(
                              value: _currentSliderValue,
                              min: 1,
                              max: 10,
                              divisions: 9,
                              activeColor: FOOTSAPP_THEME_GREEN,
                              label: _currentSliderValue.round().toString(),
                              onChanged: (double value) {
                                debugPrint('value: $value');
                                setState(() {
                                  _currentSliderValue = value;
                                });

                                viewmodel
                                        .userProfile.numberOfTimesPlayedWeekly =
                                    _currentSliderValue.ceil();
                                debugPrint(
                                    '${viewmodel.userProfile.numberOfTimesPlayedWeekly.toString()}');
                              },
                            ),
                          ),
                          Text(
                            'When’s your birthday?',
                            textAlign: TextAlign.center,
                            style: kWhiteTextStyleNormal.copyWith(
                                fontSize: sw.sHeight(17),
                                fontFamily: 'Proxima-Nova'),
                          ),
                          SizedBox(
                            height: sw.sHeight(16),
                          ),
                          GestureDetector(
                            onTap: () {
                              _dobTap(context, viewmodel);
                            },
                            child: Container(
                              height: sw.sHeight(55),
                              width: sw.sWidth(240),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: FOOTSAPP_THEME_GREEN),
                              ),
                              child: Center(
                                child: Text(
                                  '$dateText',
                                  style: kWhiteTextStyleNormal,
                                ),
                              ),
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
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: sw.sHeight(28),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          //temporary call
                          // await Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (_) => BottomNavContainer()),
                          // );

                          CommonLoaderDialog.show(
                              context, false, 'Updating profile ...',
                              key: _keyLoader);

                          debugPrint('${viewmodel.userProfile.toString()}');

                          final _userDataResponse =
                              await viewmodel.completeProfileUpdate();

                          if (_userDataResponse.success == true) {
                            SchedulerBinding.instance
                                .addPostFrameCallback((_) async {
                              Navigator.of(_keyLoader.currentContext,
                                      rootNavigator: true)
                                  .pop();

                              await Navigator.pushNamedAndRemoveUntil(
                                context,
                                BottomNavContainer.SCREEN_ID,
                                (route) => false,
                              );
                            });
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

  void _dobTap(BuildContext context, UserProfileViewModel viewmodel) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return _buildBottomPicker(
          CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: DateTime(1991),
            maximumYear: 2015,
            onDateTimeChanged: (DateTime newDate) {
              setState(() {
                date = newDate;
                dateText = "${date.day}/${date.month}/${date.year}";
              });
              viewmodel.userProfile.birthday = dateText;
            },
          ),
        );
      },
    );
  }

  Widget _buildBottomPicker(Widget picker) {
    return Container(
      height: sw.sHeight(216),
      padding: EdgeInsets.only(top: sw.sHeight(6)),
      color: Colors.white, //CupertinoColors.white,
      child: DefaultTextStyle(
        style: TextStyle(
          color: CupertinoColors.black,
          fontSize: sw.sHeight(22),
        ),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () {},
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }
}
