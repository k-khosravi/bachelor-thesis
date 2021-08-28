import 'dart:async';

import 'package:flutter/material.dart';

import '../../utils/assets_urls.dart' as assets;
import '../../utils/color_utils.dart' as colors;

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    _boot();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colors.splashBackground,
        body: Center(
            child: Image(
          image: AssetImage(assets.wifiGif),
        )));
  }

  _boot() {
    Future.delayed(const Duration(seconds: 8), () {
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
    });
  }
}
