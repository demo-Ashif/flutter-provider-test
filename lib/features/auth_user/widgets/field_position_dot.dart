import 'package:flutter/material.dart';
import 'package:footsapp/common_ui/color_theme.dart';
import 'package:footsapp/core/utils/screen_aware_size.dart';
import 'package:footsapp/core/view_models/user_profile_viewmodel.dart';
import 'package:provider/provider.dart';

class FieldPositionDot extends StatelessWidget {
  //final Function onDotClick;
  final int fieldPositionIndex;

  const FieldPositionDot({
    Key key,
    //@required this.onDotClick,
    @required this.fieldPositionIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sw = ScreenAwareSize(context);
    return Consumer<UserProfileViewModel>(
        builder: (context, viewmodel, child) => GestureDetector(
              onTap: () {
                viewmodel.setCurrentSelectedFieldPosition(fieldPositionIndex);
              },
              child: Container(
                padding: EdgeInsets.all(sw.sHeight(3)),
                width: sw.sWidth(14),
                height: sw.sHeight(14),
                decoration: BoxDecoration(
                  border: Border.all(color: FOOTSAPP_THEME_GREEN, width: 1),
                  shape: BoxShape.circle,
                  color: fieldPositionIndex ==
                          viewmodel.currentSelectedFieldPosition
                      ? Colors.redAccent
                      : Colors.white60,
                ),
              ),
            ));
  }
}
