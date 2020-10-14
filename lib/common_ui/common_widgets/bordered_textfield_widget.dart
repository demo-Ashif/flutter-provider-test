import 'package:flutter/material.dart';
import 'package:footsapp/common_ui/color_theme.dart';
import 'package:footsapp/common_ui/style_constants.dart';
import 'package:footsapp/core/utils/screen_aware_size.dart';

class BorderedTextField extends StatelessWidget {
  final TextInputType textInputType;
  final TextEditingController controller;
  final bool isPhone;
  final bool obscureText;
  final bool readOnly;
  final String hintText;
  final String labelText;
  final Function validator;

  const BorderedTextField({
    Key key,
    @required this.textInputType,
    @required this.controller,
    @required this.isPhone,
    this.obscureText = false,
    this.readOnly = false,
    @required this.hintText,
    @required this.labelText,
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
      readOnly: readOnly,
      obscureText: obscureText,
      cursorColor: FOOTSAPP_THEME_GREEN,
      cursorWidth: 1,
      validator: validator,
      controller: controller,
      maxLength: isPhone ? 11 : null,
      style: kWhiteTextStyleNormal.copyWith(
        fontSize: sw.sHeight(16),
      ),
      decoration: kInputDecorationBordered.copyWith(
          labelText: labelText, hintText: hintText),
      textInputAction: TextInputAction.done,
    );
  }
}
