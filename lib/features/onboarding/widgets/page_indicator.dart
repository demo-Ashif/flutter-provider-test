import 'package:flutter/material.dart';
import 'package:footsapp/features/onboarding/screens/onboarding.dart';
import 'package:footsapp/features/onboarding/screens/pages.dart';

class PageIndicators extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: OnBoardingInherited.of(context).bloc.activeIndex,
      builder: (context, snapshot) {
        final index = snapshot.data;
        List<Indicator> indicators = [];
        for (var i = 0; i < pages.length; ++i) {
          indicators.add(Indicator(i == index ? true : false));
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: indicators,
        );
      },
    );
  }
}

class Indicator extends StatelessWidget {
  final bool isActive;

  Indicator(this.isActive);

  final Color _activeColor = Colors.white;
  final Color _inactiveColor = Colors.white.withOpacity(0.53);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 16.0),
      child: Container(
        height: isActive ? 15.0 : 10.0,
        width: isActive ? 15.0 : 10.0,
        decoration: BoxDecoration(
          color: isActive ? _activeColor : _inactiveColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
