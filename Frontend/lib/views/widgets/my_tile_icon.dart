import 'package:flutter/material.dart';

import '../../utils/color_utils.dart' as colors;

class TileLeadingIcon extends StatelessWidget {
  final IconData iconData;

  TileLeadingIcon({required this.iconData});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Icon(iconData, size: width / 12, color: colors.accentColor);
  }
}
