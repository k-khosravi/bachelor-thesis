import 'package:flutter/material.dart';

import '../widgets/shapes/pentagon_shape.dart';

class CollectButton extends StatelessWidget {
  final Function callBack;
  final double fontSize;
  final bool loading;

  CollectButton(
      {required this.fontSize, required this.callBack, this.loading = false});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
        width: width / 5,
        height: height / 8,
        child: InkWell(
            onTap: () => loading ? callBack() : print(''),
            child: CustomPaint(
                painter: PentagonShape(lineColor: Color(0xff20ab1c)),
                child: Center(
                    child: Icon(Icons.check,
                        color: Color(0xff105111), size: 50)))));
  }
}
