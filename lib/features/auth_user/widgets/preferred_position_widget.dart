import 'package:flutter/material.dart';
import 'package:footsapp/common_ui/color_theme.dart';
import 'package:footsapp/core/constants/value_constants.dart';
import 'package:footsapp/core/utils/screen_aware_size.dart';
import 'package:footsapp/features/auth_user/widgets/pitch_painter.dart';

import '../../../core/utils/screen_aware_size.dart';
import 'field_position_dot.dart';
import 'field_position_text.dart';

class PreferredPositionWidget extends StatefulWidget {
  const PreferredPositionWidget({
    Key key,
  }) : super(key: key);

  @override
  _PreferredPositionWidgetState createState() =>
      _PreferredPositionWidgetState();
}

class _PreferredPositionWidgetState extends State<PreferredPositionWidget> {
  ScreenAwareSize sw;

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
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: sw.sWidth(270),
              height: sw.sHeight(150),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: FOOTSAPP_THEME_GREEN, width: 1.5),
              ),
              child: CustomPaint(
                painter: PitchPainter(),
              ),
              //width: 100,
            ),
            Container(
              width: sw.sWidth(270),
              height: sw.sHeight(150),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: sw.sWidth(12)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FieldPositionDot(
                          fieldPositionIndex: 1,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: sw.sWidth(16)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FieldPositionDot(
                          fieldPositionIndex: 2,
                        ),
                        FieldPositionDot(
                          fieldPositionIndex: 3,
                        ),
                        FieldPositionDot(
                          fieldPositionIndex: 4,
                        ),
                        FieldPositionDot(
                          fieldPositionIndex: 5,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: sw.sWidth(22)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FieldPositionDot(
                          fieldPositionIndex: 6,
                        ),
                        FieldPositionDot(
                          fieldPositionIndex: 7,
                        ),
                        FieldPositionDot(
                          fieldPositionIndex: 8,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: sw.sWidth(6)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FieldPositionDot(
                          fieldPositionIndex: 9,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: sw.sWidth(24)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FieldPositionDot(
                          fieldPositionIndex: 10,
                        ),
                        FieldPositionDot(
                          fieldPositionIndex: 11,
                        ),
                        FieldPositionDot(
                          fieldPositionIndex: 12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: sw.sHeight(16),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FieldPositionText(
              positionText: 'GK',
              positionSegment: POSITION_SEGMENT_GK,
            ),
            FieldPositionText(
              positionText: 'DEF',
              positionSegment: POSITION_SEGMENT_DEF,
            ),
            FieldPositionText(
              positionText: 'MID',
              positionSegment: POSITION_SEGMENT_MID,
            ),
            FieldPositionText(
              positionText: 'ATT',
              positionSegment: POSITION_SEGMENT_ATT,
            ),
          ],
        ),
      ],
    );
  }
}
