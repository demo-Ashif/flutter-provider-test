import 'package:flutter/material.dart';

import '../screens/onboarding.dart';

class PageSwipe extends StatefulWidget {
  final Widget child;

  PageSwipe({this.child});

  @override
  _PageSwipeState createState() => _PageSwipeState();
}

enum Swipe { Left, Right, None }

class _PageSwipeState extends State<PageSwipe> {
  final double swipeThreshold = 80.0;

  double previousPosition;

  Swipe swipe;

  _dragStart(DragStartDetails details) {
    previousPosition = details.globalPosition.dx;
    swipe = Swipe.None;
  }

  _dragEnd(DragEndDetails details, BuildContext context) {
    previousPosition = null;
    if (swipe != Swipe.None) {
      OnBoardingInherited.of(context).bloc.event.add(swipe);
    }
  }

  _dragUpdate(DragUpdateDetails details) {
    if (previousPosition != null) {
      final deltaX = details.globalPosition.dx - previousPosition;
      if (deltaX.abs() > swipeThreshold) {
        if (deltaX < 0) {
          // print('Swipe Left Update -> $details');
          swipe = Swipe.Left;
        } else if (deltaX > 0) {
          // print('Swipe Right Update -> $details');
          swipe = Swipe.Right;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: widget.child,
      onHorizontalDragStart: _dragStart,
      onHorizontalDragUpdate: _dragUpdate,
      onHorizontalDragEnd: (d) => _dragEnd(d, context),
    );
  }
}
