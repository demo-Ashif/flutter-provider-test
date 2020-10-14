import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:footsapp/common_ui/color_theme.dart';
import 'package:footsapp/core/constants/value_constants.dart';
import 'package:footsapp/core/di/injection_container.dart';
import 'package:footsapp/core/utils/screen_aware_size.dart';
import 'package:footsapp/core/view_models/bottom_nav_viewmodel.dart';

class CustomFab extends StatefulWidget {
  @override
  _CustomFabState createState() => _CustomFabState();
}

class _CustomFabState extends State<CustomFab> {
  ScreenAwareSize sw;

  final navViewModel = sl<BottomNavViewModel>();

  @override
  void initState() {
    super.initState();
    sw = ScreenAwareSize(context);
  }

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      marginBottom: sw.sHeight(5),

      backgroundColor: FOOTSAPP_THEME_GREEN,
      //Colors.red[200],
      overlayColor: FOOTSAPP_THEME_NAVY,
      //Colors.black87,
      marginRight: (MediaQuery.of(context).size.width / 2) - sw.sWidth(28),
      child: const Icon(Icons.add, color: FOOTSAPP_THEME_NAVY //Colors.black,
          ),
      animatedIconTheme: IconThemeData(
        size: sw.sWidth(22),
      ),
      elevation: 8.0,
      curve: Curves.bounceIn,
      tooltip: "Options",
      visible: true,
      shape: CircleBorder(),
      children: [
        SpeedDialChild(
          labelBackgroundColor: Colors.white,
          child: Icon(
            FontAwesomeIcons.users,
            color: FOOTSAPP_THEME_NAVY,
          ),
          labelStyle: TextStyle(
            fontSize: sw.sHeight(14),
            color: FOOTSAPP_THEME_NAVY,
            fontWeight: FontWeight.w600,
          ),
          label: "Create Group",
          backgroundColor: FOOTSAPP_THEME_GREEN,
          onTap: () async {
            // Create Group Tap
            // Provider.of<BottomNavViewModel>(context).currentPage =
            //     NAV_ITEM_GROUPS;
            navViewModel.currentPage = NAV_ITEM_GROUPS;

            // Navigator.of(context).push(MaterialPageRoute(
            //   builder: (context) => CreateNewGroupMainView(),
            // ));
          },
        ),
        SpeedDialChild(
          child: Icon(
            FontAwesomeIcons.futbol,
            color: FOOTSAPP_THEME_NAVY,
          ),
          labelBackgroundColor: Colors.white,
          backgroundColor: FOOTSAPP_THEME_GREEN,
          labelStyle: TextStyle(
            fontSize: sw.sHeight(14),
            color: FOOTSAPP_THEME_NAVY,
            fontWeight: FontWeight.w600,
          ),
          label: "Create Game",
          onTap: () {
            // Create Game tap
          },
        ),
      ],
    );
  }
}
