import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

import '../../utils/assets_urls.dart' as assets;
import '../../utils/color_utils.dart' as colors;
import '../../utils/string_utils.dart' as strings;

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  List<Slide> slides = [];

  @override
  void initState() {
    _initSlides();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: slides,
      showSkipBtn: false,
      colorDot: colors.dotColor,
      colorActiveDot: colors.activeDotColor,
    );
  }

  _initSlides() {
    slides.add(_createSlide(strings.offlinePhase,
        strings.offlinePhaseDescription, assets.offlinePhaseIntro));
    slides.add(_createSlide(strings.onlinePhase, strings.onlinePhaseDescription,
        assets.onlinePhaseIntro));
    slides.add(_createSlide(
        strings.wifiScanner, strings.wifiScannerDescription, assets.wifiScannerIntro));
  }

  Slide _createSlide(String title, String description, String imagePath) {
    return Slide(
        title: title,
        styleTitle: TextStyle(
            color: colors.textColor, fontSize: 30, fontWeight: FontWeight.bold),
        pathImage: imagePath,
        description: description,
        styleDescription:
            TextStyle(color: colors.descriptionText, fontSize: 18),
        backgroundColor: colors.primaryColor);
  }
}
