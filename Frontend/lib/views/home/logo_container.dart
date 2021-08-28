import 'package:flutter/material.dart';

import '../../utils/assets_urls.dart' as assets;

class LogoContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        alignment: Alignment.center,
        height: height / 5,
        child: Image.asset(assets.logo, width: width, fit: BoxFit.scaleDown));
  }
}
