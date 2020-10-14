import 'package:flutter/material.dart';

class ScreenAwareSize {
  static final ScreenAwareSize _instance = ScreenAwareSize._internal();

  ScreenAwareSize._internal();

  final double baseHeight = 759;
  final double baseWidth = 392;
  BuildContext context;

  factory ScreenAwareSize(BuildContext context) {
    assert(
      _instance != null,
      '\nEnsure to initialize ScreenAwareSize before accessing it.',
    );
    _instance.context = context;
    return _instance;
  }

  double sHeight(double size) {
    return size * MediaQuery.of(context).size.height / baseHeight;
  }

  double sWidth(double size) {
    return size * MediaQuery.of(context).size.width / baseWidth;
  }
}
