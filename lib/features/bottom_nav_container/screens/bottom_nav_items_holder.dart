import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footsapp/common_ui/color_theme.dart';
import 'package:footsapp/core/constants/value_constants.dart';
import 'package:footsapp/core/utils/screen_aware_size.dart';

import '../../../core/utils/screen_aware_size.dart';
import '../widgets/bottom_nav_item.dart';

class BottomNavItemsHolder extends StatefulWidget {
  final ValueChanged<int> callback;

  final int currentIndex;

  const BottomNavItemsHolder({Key key, this.callback, this.currentIndex})
      : super(key: key);

  @override
  _BottomNavItemsHolderState createState() => _BottomNavItemsHolderState();
}

class _BottomNavItemsHolderState extends State<BottomNavItemsHolder> {
  final _bottomBarBorder = 20.0;
  ScreenAwareSize sw;

  List items = [
    NavItem("Home", FontAwesomeIcons.home),
    NavItem("Games", FontAwesomeIcons.futbol),
    NavItem("abc", FontAwesomeIcons.futbol),
    NavItem("Groups", FontAwesomeIcons.users),
    NavItem("Profile", FontAwesomeIcons.solidUserCircle),
  ];

  void _updateIndex(int index) {
    widget.callback(index);
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[],
        color: FOOTSAPP_THEME_NAVY,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(_bottomBarBorder),
          topRight: Radius.circular(_bottomBarBorder),
        ),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[for (var i = 0; i < 5; ++i) buildNavItems(i)],
      ),
    );
  }

  Widget buildNavItems(int i) {
    if (i == NAV_ITEM_FAB) {
      return Container(
        height: sw.sHeight(10),
        width: sw.sWidth(24),
      );
    }
    return BottomNavItem(
      callback: _updateIndex,
      icon: items[i].icon,
      text: items[i].title,
      index: i,
      isSelected: widget.currentIndex == i,
    );
  }
}

class NavItem {
  final String title;
  final IconData icon;

  NavItem(this.title, this.icon);
}
