import 'package:flutter/material.dart';
import 'package:footsapp/common_ui/color_theme.dart';
import 'package:footsapp/core/utils/screen_aware_size.dart';

class BottomNavItem extends StatelessWidget {
  final ValueChanged<int> callback;
  final String text;
  final IconData icon;
  final double iconSize;
  final Color textColor;
  final bool isSelected;

  final int index;

  const BottomNavItem({
    Key key,
    @required this.callback,
    @required this.text,
    @required this.icon,
    this.iconSize,
    this.textColor,
    this.isSelected = false,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sw = ScreenAwareSize(context);
    final _selectedColor = Colors.grey[800].withOpacity(0.66);
    final _selectedItemBorderRadius = 20.0;
    final _borderBottom = BorderRadius.only(
      bottomLeft: Radius.circular(_selectedItemBorderRadius),
      bottomRight: Radius.circular(_selectedItemBorderRadius),
    );
    return Material(
      type: MaterialType.button,
      elevation: isSelected ? 2.0 : 0.0,
      borderRadius: _borderBottom,
      color: isSelected ? _selectedColor : Colors.transparent,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () => callback(index),
        borderRadius: _borderBottom,
        child: Padding(
          padding: EdgeInsets.all(sw.sHeight(12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: sw.sHeight(24),
                color: isSelected
                    ? FOOTSAPP_THEME_GREEN
                        .withOpacity(0.88) //Colors.amber[200].withOpacity(0.88)
                    : Colors.grey[600],
              ),
              SizedBox(height: 2.0),
              Text(
                text,
                style: Theme.of(context).textTheme.button.copyWith(
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w500,
                      fontSize: sw.sHeight(13),
                      color: isSelected
                          ? FOOTSAPP_THEME_GREEN.withOpacity(
                              0.88) //Colors.amber[200].withOpacity(0.88)
                          : Colors.grey[600],
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
