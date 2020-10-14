import 'package:flutter/material.dart';
import 'package:footsapp/common_ui/color_theme.dart';

class PitchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    //print('${size.width} ... ${size.height}');
    final pitchPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = FOOTSAPP_THEME_GREEN;

    canvas.drawRect(
        Rect.fromLTWH(0, size.height / 4, size.width / 8.8, size.height / 2),
        pitchPaint);
    canvas.drawLine(Offset(size.width / 2, size.height),
        Offset(size.width / 2, 0), pitchPaint);
    canvas.drawRect(
        Rect.fromLTWH(size.width - (size.width / 8.8), size.height / 4,
            size.width / 8.8, size.height / 2),
        pitchPaint);
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 8.8, pitchPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
