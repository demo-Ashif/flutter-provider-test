import 'package:flutter/material.dart';
import 'package:footsapp/common_ui/color_theme.dart';
import 'package:footsapp/common_ui/style_constants.dart';
import 'package:footsapp/core/utils/screen_aware_size.dart';

class LinedTextField extends StatelessWidget {
  final TextInputType textInputType;
  final TextEditingController controller;
  final bool isPhone;
  final bool obscureText;
  final String hintText;
  final Function validator;

  const LinedTextField({
    Key key,
    @required this.textInputType,
    @required this.controller,
    @required this.isPhone,
    this.obscureText = false,
    @required this.hintText,
    @required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sw = ScreenAwareSize(context);
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: textInputType,
      textCapitalization: TextCapitalization.words,
      maxLines: 1,
      obscureText: obscureText,
      cursorColor: FOOTSAPP_THEME_GREEN,
      cursorWidth: 1,
      validator: validator,
      controller: controller,
      maxLength: isPhone ? 11 : null,
      style: kWhiteTextStyleNormal.copyWith(
        fontSize: sw.sHeight(16),
      ),
      decoration: kInputDecorationLined.copyWith(
        isDense: isPhone ? true : false,
        hintText: hintText,
        hintStyle: kHintTextStyleNormal.copyWith(
          fontSize: sw.sHeight(16),
        ),
      ),
      textInputAction: TextInputAction.done,
    );
  }
}
