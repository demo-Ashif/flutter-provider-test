import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:footsapp/core/utils/screen_aware_size.dart';

class FilledButton extends StatelessWidget {
  final String text;
  final Color textColor, iconColor, backgroundColor, splashColor;
  final double elevation;
  final Function onPressed;

  FilledButton({
    Key key,
    @required this.backgroundColor,
    @required this.onPressed,
    @required this.text,
    this.textColor = Colors.white,
    this.iconColor = Colors.white,
    this.splashColor = Colors.white30,
    this.elevation = 2.0,
  })  : assert(text != null),
        assert(textColor != null),
        assert(backgroundColor != null),
        assert(onPressed != null),
        assert(elevation != null);

  @override
  Widget build(BuildContext context) {
    final sw = ScreenAwareSize(context);

    return MaterialButton(
      key: key,
      minWidth: sw.sWidth(35),
      height: sw.sHeight(50),
      elevation: elevation,
      padding: EdgeInsets.all(0),
      color: backgroundColor,
      onPressed: onPressed,
      splashColor: splashColor,
      child: _getButtonChild(context, sw),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }

  /// Get the inner content of a button
  Widget _getButtonChild(BuildContext context, ScreenAwareSize sw) {
    return Container(
      //padding: EdgeInsets.only(right: sw.sWidth(24)),
      width: sw.sWidth(220),
      constraints: BoxConstraints(
        maxWidth: sw.sWidth(220),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: textColor,
          fontFamily: 'Proxima-Nova',
          fontWeight: FontWeight.w600,
          fontSize: sw.sHeight(17),
        ),
      ),
    );
  }
}
