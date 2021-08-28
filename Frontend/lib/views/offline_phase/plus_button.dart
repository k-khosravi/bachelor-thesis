import 'package:flutter/material.dart';

import '../../utils/color_utils.dart' as colors;

typedef void AddCallBack(int val);

class PlusButton extends StatelessWidget {
  final AddCallBack callBack;
  final IconData icon;

  PlusButton({required this.icon, required this.callBack});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ElevatedButton(
            onPressed: () => callBack(60),
            child: Icon(icon, color: colors.accentDarkColor),
            style: ElevatedButton.styleFrom(
                primary: colors.backgroundColor,
                shape: CircleBorder(),
                side: BorderSide(width: 2.0, color: colors.accentDarkColor))));
  }
}
