import 'package:flutter/material.dart';
import 'package:footsapp/common_ui/color_theme.dart';
import 'package:footsapp/common_ui/style_constants.dart';
import 'package:footsapp/core/utils/screen_aware_size.dart';
import 'package:footsapp/core/view_models/user_profile_viewmodel.dart';
import 'package:provider/provider.dart';

class FieldPositionText extends StatelessWidget {
  final String positionText;
  final int positionSegment;

  const FieldPositionText({
    Key key,
    @required this.positionText,
    @required this.positionSegment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sw = ScreenAwareSize(context);
    return Consumer<UserProfileViewModel>(
      builder: (context, viewmodel, child) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          positionText,
          style: kWhiteTextStyleNormal.copyWith(
            fontSize: positionSegment == viewmodel.fieldPositionSegment
                ? sw.sHeight(21)
                : sw.sHeight(18),
            color: positionSegment == viewmodel.fieldPositionSegment
                ? FOOTSAPP_THEME_GREEN
                : Colors.white,
          ),
        ),
      ),
    );
  }
}
