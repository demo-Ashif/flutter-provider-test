import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavPageHolder extends StatelessWidget {
  final Widget bottomNavChildPage;
  final int pageIndex;

  const BottomNavPageHolder({
    Key key,
    this.bottomNavChildPage,
    this.pageIndex = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bottomNavChildPage,
    );
  }
}
