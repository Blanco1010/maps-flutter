part of 'custom_market.dart';

class MarkerDestinationPainter extends CustomPainter {
  final String description;
  final double metres;

  MarkerDestinationPainter(this.description, this.metres);

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

    path.moveTo(0, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 100);
    path.lineTo(0, 100);
    canvas.drawShadow(path, Colors.black87, 10, false);

    // Box white
    final whiteBox = Rect.fromLTWH(0, 20, size.width - 24, 80);
    canvas.drawRect(whiteBox, paint);

    // Box blacks
    paint.color = Colors.black;
    final blackBox = Rect.fromLTWH(0, 20, 70, 80);
    canvas.drawRect(blackBox, paint);

    double kilometres = this.metres / 1000;
    kilometres = (kilometres * 100).floor().toDouble();
    kilometres = kilometres / 100;
    // method for drawing text

    //Draw the text for numbers
    TextPainter textPainter =
        _drawText('$kilometres', 22, maxWidth: 80, minWidth: 80);
    textPainter.paint(canvas, Offset(-5, 35));

    //Draw the text "minutes"
    textPainter = _drawText('Km', 20, maxWidth: 70, minWidth: 70);
    textPainter.paint(canvas, Offset(5, 70));

    //My ubication
    textPainter = _drawText(
      this.description,
      20,
      color: Colors.black,
      maxWidth: size.width - 110,
      maxLines: 3,
      textAlign: TextAlign.justify,
    );

    textPainter.paint(canvas, Offset(75, 25));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
