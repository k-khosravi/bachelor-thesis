import 'package:flutter/material.dart';

class HexagonShape extends CustomPainter {
  Color shapeColor;
  HexagonShape({
    required this.shapeColor
});
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    Path p = getPath(size);
    Paint paint = Paint();
    paint.strokeWidth = 3;
    paint.style = PaintingStyle.stroke;
    paint.strokeJoin = StrokeJoin.round;
    paint.shader = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Color(0xff3ae6dd),
        Color(0xffd392eb),

      ],
    ).createShader(rect);

    canvas.drawPath(p,paint);
  }

  Path getPath(Size size) {
    var width = size.width ;
    var height = size.height;
    final path = Path();
    path.moveTo(size.width/2, 0);
    path.lineTo(0, height * 0.1);
    path.lineTo(0, height * 0.9);
    path.lineTo(width / 2, height);
    path.lineTo(width, height * 0.9 );
    path.lineTo(width, height * 0.1);
    path.close();
    return path;
  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}