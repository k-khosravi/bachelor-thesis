import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PentagonShape extends CustomPainter {
  
  Color lineColor;
  PentagonShape({
    required this.lineColor
  });
  @override
  void paint(Canvas canvas, Size size) {
    Path p = getPath(size);
    canvas.drawPath(p, Paint()
      ..strokeWidth = 3
      ..color = lineColor
      ..style = PaintingStyle.fill
      ..strokeJoin = StrokeJoin.round
    );
  }

  Path getPath(Size size) {
    var width = size.width ;
    var height = size.height;
    final path = Path();
    path.moveTo(width/2, 0);
    path.lineTo(0, height * 0.2);
    path.quadraticBezierTo(
        0, height * 0.8, width / 2 , height);
    path.quadraticBezierTo(
        width, height * 0.8, width , height * 0.2);
    path.lineTo(width, height * 0.2);
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}