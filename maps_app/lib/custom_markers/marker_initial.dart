part of 'custom_market.dart';

class MarkerInitialPainter extends CustomPainter {
  final int minutes;

  MarkerInitialPainter(this.minutes);

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

    // Box blacks
    paint.color = Colors.black;
    final blackBox = Rect.fromLTWH(40, 20, 70, 80);
    canvas.drawRect(blackBox, paint);

    // method for drawing text

    //Draw the text for numbers
    TextPainter textPainter = _drawText('$minutes', 30);
    textPainter.paint(canvas, Offset(40, 35));

    //Draw the text "minutes"
    textPainter = _drawText('Min', 20);
    textPainter.paint(canvas, Offset(40, 70));

    //My ubication
    textPainter = _drawText('Mi ubicación', 20,
        color: Colors.black, maxWidth: size.width - 130);
    textPainter.paint(canvas, Offset(130, 50));
  }

  @override
  bool shouldRepaint(MarkerInitialPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(MarkerInitialPainter oldDelegate) => false;
}

TextPainter _drawText(
  String text,
  double size, {
  Color color = Colors.white,
  double maxWidth = 70,
  double minWidth = 70,
  TextAlign textAlign = TextAlign.center,
  int maxLines = 1,
}) {
  TextSpan textSpan = new TextSpan(
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w400,
    ),
    text: text,
  );

  final textPainter = new TextPainter(
    text: textSpan,
    textDirection: TextDirection.ltr,
    textAlign: textAlign,
    maxLines: maxLines,
    ellipsis: '...',
  );
  textPainter.layout(
    maxWidth: maxWidth,
    minWidth: minWidth,
  );
  return textPainter;
}
