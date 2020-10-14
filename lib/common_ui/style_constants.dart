import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:footsapp/common_ui/color_theme.dart';

const kWhiteTextStyleNormal = TextStyle(
  color: Colors.white,
  fontFamily: 'D-Din',
  fontWeight: FontWeight.w500,
);

const kErrorTextStyle = TextStyle(
  color: Colors.redAccent,
  fontFamily: 'D-Din',
  fontWeight: FontWeight.w500,
);
const kHintTextStyleNormal = TextStyle(
  color: Colors.white60,
  fontFamily: 'D-Din',
  fontWeight: FontWeight.w500,
);

const kGreenTextStyleNormal = TextStyle(
  color: FOOTSAPP_THEME_GREEN,
  fontFamily: 'D-Din',
  fontWeight: FontWeight.w500,
);

const kGreenTextStyleBold = TextStyle(
  color: FOOTSAPP_THEME_GREEN,
  fontFamily: 'Proxima-Nova',
  fontWeight: FontWeight.w600,
);

const kNavyTextStyleNormal = TextStyle(
  color: FOOTSAPP_THEME_NAVY,
  fontFamily: 'D-Din',
  fontWeight: FontWeight.w500,
);

const kNavyTextStyleBold = TextStyle(
  color: FOOTSAPP_THEME_NAVY,
  fontFamily: 'D-Din',
  fontWeight: FontWeight.w600,
);

const kInputDecorationLined = InputDecoration(
  isDense: false,
  errorMaxLines: 2,
  errorStyle: kErrorTextStyle,
  hintStyle: kHintTextStyleNormal,
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: FOOTSAPP_THEME_GREEN,
    ),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: FOOTSAPP_THEME_GREEN,
      width: 2.0,
    ),
  ),
  focusedErrorBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.redAccent,
      width: 2.0,
    ),
  ),
  errorBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.redAccent,
      width: 2.0,
    ),
  ),
);

const kInputDecorationBordered = InputDecoration(
  isDense: false,
  errorMaxLines: 2,
  contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
  errorStyle: kErrorTextStyle,
  hintStyle: kHintTextStyleNormal,
  labelStyle: kHintTextStyleNormal,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      const Radius.circular(10.0),
    ),
    borderSide: BorderSide(
      color: FOOTSAPP_THEME_GREEN,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      const Radius.circular(10.0),
    ),
    borderSide: BorderSide(
      color: FOOTSAPP_THEME_GREEN,
    ),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      const Radius.circular(10.0),
    ),
    borderSide: BorderSide(
      color: Colors.redAccent,
    ),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      const Radius.circular(10.0),
    ),
    borderSide: BorderSide(
      color: Colors.redAccent,
    ),
  ),
);
