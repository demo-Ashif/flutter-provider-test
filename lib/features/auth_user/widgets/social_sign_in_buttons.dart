import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:footsapp/core/utils/screen_aware_size.dart';

class SocialSignInButtons extends StatelessWidget {
  final IconData icon;
  final Widget image;
  final String text;
  final double fontSize;
  final Color textColor, iconColor, backgroundColor, splashColor;
  final Function onPressed;
  final ShapeBorder shape;
  final double elevation;
  final double height;
  final double width;

  SocialSignInButtons({
    Key key,
    @required this.backgroundColor,
    @required this.onPressed,
    @required this.text,
    this.icon,
    this.image,
    this.fontSize = 14.0,
    this.textColor = Colors.white,
    this.iconColor = Colors.white,
    this.splashColor = Colors.white30,
    this.elevation = 2.0,
    this.shape,
    this.height,
    this.width,
  })  : assert(text != null),
        assert(icon != null || image != null),
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
      height: height,
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
      padding: EdgeInsets.only(right: sw.sWidth(24)),
      width: sw.sWidth(220),
      constraints: BoxConstraints(
        maxWidth: width ?? sw.sWidth(220),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(
              sw.sWidth(5),
            ),
            child: Container(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: _getIconOrImage(sw)),
            ),
          ),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontFamily: 'Proxima-Nova',
                fontWeight: FontWeight.w500,
                fontSize: fontSize,
                backgroundColor: Color.fromRGBO(0, 0, 0, 0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Get the icon or image widget
  Widget _getIconOrImage(ScreenAwareSize sw) {
    if (image != null) {
      return image;
    }
    return Icon(
      icon,
      size: sw.sWidth(36),
      color: this.iconColor,
    );
  }
}
