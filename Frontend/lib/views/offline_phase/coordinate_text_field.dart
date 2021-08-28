import 'package:flutter/material.dart';

import '../../utils/color_utils.dart' as colors;

class CoordinateTextField extends StatelessWidget {
  final String text;
  final String labelText;

  CoordinateTextField({required this.text, required this.labelText});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return _coordinateTextField(width, height);
  }

  Widget _coordinateTextField(double width, double height) {
    return Container(
        width: width * 1.4 / 3,
        height: height / 10,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2.0, color: colors.accentDarkColor)),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(labelText, style: TextStyle(color: colors.grey, fontSize: 16)),
          Expanded(
              child: Center(
                  child: Text(text,
                      style:
                          TextStyle(color: colors.primaryColor, fontSize: 16))))
        ]));
  }
}
