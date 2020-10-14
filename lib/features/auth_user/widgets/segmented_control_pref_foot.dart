import 'package:flutter/material.dart';
import 'package:footsapp/common_ui/color_theme.dart';
import 'package:footsapp/common_ui/style_constants.dart';
import 'package:footsapp/core/utils/images.dart';
import 'package:footsapp/core/utils/screen_aware_size.dart';

class SegmentedControlPrefFoot extends StatefulWidget {
  final List<String> segments;
  final ValueChanged<int> onSegmentTap;
  final int selectedIndex;

  const SegmentedControlPrefFoot({
    Key key,
    @required this.segments,
    this.onSegmentTap,
    this.selectedIndex,
  }) : super(key: key);

  @override
  _SegmentedControlPrefFootState createState() =>
      _SegmentedControlPrefFootState();
}

class _SegmentedControlPrefFootState extends State<SegmentedControlPrefFoot> {
  var selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final _containerPadding = 0.0;
    return Container(
      padding: EdgeInsets.all(_containerPadding),
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
              width: 1, color: FOOTSAPP_THEME_GREEN), //Colors.black54,
          borderRadius: BorderRadius.circular(10.0)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SegmentedBox(
            text: widget.segments[0],
            isSelected: 0 == selectedIndex,
            index: 0,
            onTap: () {
              setState(() {
                selectedIndex = 0;
              });
              widget.onSegmentTap(0);
            },
          ),
          SegmentedBox(
            text: widget.segments[1],
            isSelected: 1 == selectedIndex,
            index: 1,
            onTap: () {
              setState(() {
                selectedIndex = 1;
              });
              widget.onSegmentTap(1);
            },
          ),
        ],
      ),
    );
  }
}

class SegmentedBox extends StatelessWidget {
  final _verticalPadding = 5.0;
  final _horizontalPadding = 8.0;
  final bool isSelected;
  final String text;
  final int index;
  final VoidCallback onTap;

  final Color color = FOOTSAPP_THEME_GREEN; //Colors.amber[200];

  SegmentedBox(
      {@required this.text, this.isSelected = false, this.index, this.onTap})
      : assert(text != null);

  @override
  Widget build(BuildContext context) {
    final sw = ScreenAwareSize(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        width: sw.sWidth(130),
        padding: EdgeInsets.symmetric(
            vertical: sw.sHeight(8), horizontal: sw.sWidth(10)),
        decoration: isSelected
            ? BoxDecoration(
                color: color,
                borderRadius: index == 0
                    ? BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(0),
                      )
                    : BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(10),
                      ))
            : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            index == 0
                ? Container(
                    child: Image.asset(
                      '${Images.assetImagesPath}/left_boot.png',
                      height: sw.sHeight(30),
                      fit: BoxFit.contain,
                      color: isSelected ? FOOTSAPP_THEME_NAVY : Colors.white,
                    ),
                  )
                : Container(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sw.sWidth(16)),
              child: Text(
                text,
                style: kWhiteTextStyleNormal.copyWith(
                    color: isSelected
                        ? FOOTSAPP_THEME_NAVY
                        : Colors.white, //Colors.black : color,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    fontSize: sw.sHeight(16)),
              ),
            ),
            index == 1
                ? Container(
                    child: Image.asset(
                      '${Images.assetImagesPath}/right_boot.png',
                      height: sw.sHeight(30),
                      fit: BoxFit.contain,
                      color: isSelected ? FOOTSAPP_THEME_NAVY : Colors.white,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
