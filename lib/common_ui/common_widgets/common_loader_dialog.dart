import 'package:flutter/material.dart';
import 'package:footsapp/common_ui/style_constants.dart';

import '../color_theme.dart';

class CommonLoaderDialog {
  static Future<void> show(
      BuildContext context, bool barrierDismiss, String msg,
      {GlobalKey key}) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismiss,
      builder: (ctx) {
        return Dialog(
          key: key,
          backgroundColor: FOOTSAPP_THEME_NAVY,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Container(
            height: 120,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      '$msg',
                      style: kWhiteTextStyleNormal,
                    ),
                  ]),
            ),
          ),
        );
      },
    );
  }
}
