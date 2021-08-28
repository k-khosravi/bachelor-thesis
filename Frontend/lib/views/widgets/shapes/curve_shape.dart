import 'package:flutter/material.dart';

class CurveShape extends CustomPainter {
  Color shapeColor;
  CurveShape({
    required this.shapeColor
  });
  @override
  void paint(Canvas canvas, Size size) {
    Path p = getPath(size);
    Paint paint = Paint();
    paint.strokeWidth = 3;
    paint.style = PaintingStyle.stroke;
    paint.color = shapeColor;
    paint.strokeJoin = StrokeJoin.round;
    canvas.drawPath(p,paint);
  }

  Path getPath(Size size) {
    var width = size.width ;
    var height = size.height;
    final path = Path();
    path.moveTo(0, height * 0.25);
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.4,
        size.width * 0.25, size.height * 0.7);
    // path.quadraticBezierTo(size.width * 0.75, size.height * 0.8,
    //     size.width * 0.25, size.height * 0.9);
    path.lineTo(size.width  , size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}