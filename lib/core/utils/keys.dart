import 'package:flutter/material.dart';

class Keys {
  final _navigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
}
