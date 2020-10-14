import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:footsapp/common_ui/color_theme.dart';
import 'package:footsapp/core/constants/pref_constants.dart';
import 'package:footsapp/core/di/injection_container.dart';
import 'package:footsapp/features/onboarding/widgets/page_indicator.dart';
import 'package:footsapp/features/splash/screens/splashview.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/gesture.dart';
import 'onboarding_bloc.dart';
import 'pages.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  void dispose() {
    _bloc?.dispose();
    super.dispose();
  }

  final _pageController = PageController();
  OnBoardingBloc _bloc;
  final prefs = sl<SharedPreferences>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    _bloc = OnBoardingBloc();
    _bloc.eventStream.listen(
      (Swipe event) {
        final currentPageIndex = _pageController.page.round();
        // print(currentPageIndex);
        if (event == Swipe.Right) {
          if (currentPageIndex != 0) {
            _pageController.previousPage(
              curve: Curves.linear,
              duration: Duration(
                microseconds: 1,
              ),
            );
          }
        }
        if (event == Swipe.Left) {
          if (currentPageIndex < pages.length) {
            _pageController.nextPage(
              curve: Curves.linear,
              duration: Duration(
                microseconds: 1,
              ),
            );
          }
        }
      },
    );
  }

  void completeOnboarding() async {
    // set onboarding flag to false
    await setFirstTimeLaunch(false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (c) => SplashView(),
      ),
    );
  }

  Future<void> setFirstTimeLaunch(bool val) async {
    return await prefs.setBool(FIRST_APP_LAUNCH, val);
  }

  @override
  Widget build(BuildContext context) {
    return OnBoardingInherited(
      bloc: _bloc,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          PageSwipe(
            child: PageViewSlider(pageController: _pageController),
          ),
          _buildIndicator(context),
          GestureDetector(
            onTap: () {
              completeOnboarding();
            },
            child: SafeArea(
              top: true,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 16,
                        color: FOOTSAPP_THEME_NAVY,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildIndicator(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SafeArea(
        bottom: true,
        top: true,
        child: PageIndicators(),
      ),
    );
  }
}

/* Green Clipper Stuff */
class CustomPathClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final initialPoint = Offset(0, size.height * 0.15);
    path.moveTo(initialPoint.dx, initialPoint.dy);
    final fControl = Offset(size.width * 0.31, 0);
    final fEnd = Offset(size.width * 0.53, size.height * 0.17);
    path.quadraticBezierTo(fControl.dx, fControl.dy, fEnd.dx, fEnd.dy);

    final sControl = Offset(size.width * 0.80, size.height * 0.37);
    final sEnd = Offset(size.width, size.height * 0.15);
    path.quadraticBezierTo(sControl.dx, sControl.dy, sEnd.dx, sEnd.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => oldClipper != this;
}

class OnBoardingInherited extends InheritedWidget {
  final OnBoardingBloc bloc;
  final Widget child;

  OnBoardingInherited({this.bloc, this.child}) : super(child: child);

  factory OnBoardingInherited.of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(OnBoardingInherited);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => oldWidget != this;
}
