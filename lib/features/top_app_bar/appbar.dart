import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:footsapp/common_ui/color_theme.dart';
import 'package:footsapp/core/utils/screen_aware_size.dart';

import '../../core/utils/screen_aware_size.dart';

class MyAppBar extends StatefulWidget {
  const MyAppBar({
    Key key,
  }) : super(key: key);

  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  ScreenAwareSize sw;

  @override
  void initState() {
    super.initState();
    print("initState() in AppBar");
    // sw = ScreenAwareSize(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies() in AppBar");
    // sw ??= ScreenAwareSize(context);
  }

  @override
  Widget build(BuildContext ctx) {
    print("build() in AppBar");
    // Using the fresh context everytime.
    sw = ScreenAwareSize(context);
    final _iconSize = sw.sHeight(19);
    return Container(
      margin: const EdgeInsets.only(top: 10.0, bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          // Container(padding: EdgeInsets.only(right: 20.0),),
          Stack(
            overflow: Overflow.visible,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: FOOTSAPP_THEME_NAVY,
                    shape: BoxShape.circle,
//              boxShadow: _boxShadow,
                    border: Border.fromBorderSide(
                        BorderSide(color: FOOTSAPP_THEME_GREEN))),
                margin: EdgeInsets.only(right: 8.0),
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.notifications,
                  size: _iconSize,
                  color: FOOTSAPP_THEME_GREEN,
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
                top: sw.sHeight(
              10,
            )),
            child: Image.asset(
              'assets/images/footsapp-logo-light.png',
              width: MediaQuery.of(ctx).size.width * 0.42,
              fit: BoxFit.fitHeight,
            ),
          ),

          Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: FOOTSAPP_THEME_NAVY,
                    shape: BoxShape.circle,
//              boxShadow: _boxShadow,
                    border: Border.fromBorderSide(
                        BorderSide(color: FOOTSAPP_THEME_GREEN))),
                margin: EdgeInsets.only(right: 8.0),
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.message,
                  size: _iconSize,
                  color: FOOTSAPP_THEME_GREEN,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildBadge(int count) {
    return Positioned(
      top: 4,
      right: -4,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              offset: Offset(0.0, 1.0),
              color: Colors.black26,
            ),
          ],
        ),
        child: Text(
          "$count",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 11.4,
          ),
        ),
      ),
    );
  }

  Widget buildMessageArrivedDot() {
    return Positioned(
      top: 15,
      right: 15,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              offset: Offset(0.0, 1.0),
              color: Colors.black26,
            ),
          ],
        ),
      ),
    );
  }
}
