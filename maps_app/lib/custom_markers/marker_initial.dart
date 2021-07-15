import 'package:flutter/material.dart';

class MarkerInitialPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double circleBlackR = 20;
    final double circleWhiteR = 7;

    Paint paint = new Paint()..color = Colors.black87;
    // paint.color = Colors.black87 it's same as above

    //Draw black circle
    canvas.drawCircle(
      Offset(circleBlackR, size.height - circleBlackR),
      20,
      paint,
    );

    //Circle White
    paint.color = Colors.white;

    canvas.drawCircle(
      Offset(circleBlackR, size.height - circleBlackR),
      circleWhiteR,
      paint,
    );

    // shadow

    final Path path = new Path();

    path.moveTo(40, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 100);
    path.lineTo(40, 100);
    canvas.drawShadow(path, Colors.black87, 10, false);

    // Box white
    final whiteBox = Rect.fromLTWH(40, 20, size.width - 64, 80);
    canvas.drawRect(whiteBox, paint);

    // Box black
    paint.color = Colors.black;
    final blackBox = Rect.fromLTWH(40, 20, 70, 80);
    canvas.drawRect(blackBox, paint);
  }

  @override
  bool shouldRepaint(MarkerInitialPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(MarkerInitialPainter oldDelegate) => false;
}
