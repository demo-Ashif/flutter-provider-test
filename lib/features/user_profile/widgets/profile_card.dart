import 'package:flutter/material.dart';
import 'package:footsapp/common_ui/color_theme.dart';
import 'package:footsapp/core/utils/images.dart';
import 'package:footsapp/core/utils/ui_helper.dart';
import 'package:footsapp/data/models/user_data_response.dart';

class ProfileCardWidget extends StatelessWidget {
  final Profile profile;
  final Function onEditButtonClick;

  const ProfileCardWidget({
    Key key,
    @required this.profile,
    @required this.onEditButtonClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      margin: EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 12),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: FOOTSAPP_THEME_NAVY
                  .withOpacity(0.93), //Colors.black.withOpacity(0.81),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              transform: Matrix4.translationValues(0.0, -38.0, 0.0),
              child: UIHelper.avatar(url: ''),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: buildPlayerContent(context, profile),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildEditButton(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPlayerContent(context, Profile profile) {
    final double sizeBoxWidth = 38;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 64),
          Container(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            child: Text(
              profile.firstName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.0,
                fontWeight: FontWeight.w600,
              ),
              softWrap: false,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  profile.preferredPosition,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 17.0,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1.5,
            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.white30,
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Text(
              "My stats".toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15.0,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(width: sizeBoxWidth),
                buildStat(
                    title: 'Games',
                    value: '0',
                    icon: '${Images.assetImagesPath}/games_icon.png'),
                buildStat(
                    title: 'Wins',
                    value: '0',
                    icon: '${Images.assetImagesPath}/wins_icon.png'),
                SizedBox(width: sizeBoxWidth),
              ],
            ),
          ),
          SizedBox(height: 4),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(width: sizeBoxWidth),
                buildStat(
                    title: 'Goals',
                    value: '0',
                    icon: '${Images.assetImagesPath}/goal_icon.png'),
                buildStat(
                    title: 'Assists',
                    value: '0',
                    icon: '${Images.assetImagesPath}/football_boot.png'),
                SizedBox(width: sizeBoxWidth),
              ],
            ),
          ),
          SizedBox(height: 6),
        ],
      ),
    );
  }

  Widget buildEditButton(context) {
    return InkWell(
      onTap: () => onEditButtonClick(),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
            color: FOOTSAPP_THEME_GREEN, //Colors.amber[200],
            borderRadius: BorderRadius.circular(12.0)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.edit,
              color: FOOTSAPP_THEME_NAVY, //Colors.black,
              size: 15.0,
            ),
            SizedBox(width: 4),
            Text(
              "EDIT",
              style: TextStyle(
                color: FOOTSAPP_THEME_NAVY, //Colors.black,
                fontSize: 13.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStat({
    @required String title,
    @required String value,
    @required String icon,
  }) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(
            title.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.0,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 2),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                icon,
                height: 23,
                color: Colors.white,
              ),
              SizedBox(width: 12),
              Text(
                value.toUpperCase(),
                style: TextStyle(
                  color: FOOTSAPP_THEME_GREEN, //Colors.amber[200],
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
