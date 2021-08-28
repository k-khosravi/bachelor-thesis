import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'color_utils.dart' as colors;
import 'preferences_util.dart';

String get dateTime => DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now());

String getChannel(String frequency) {
  int freq = int.parse(frequency);
  if (freq > 2000 && freq < 3000)
    return 2.4.toString();
  else
    return 5.toString();
}

changeScreenToPortrait() =>
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);


changeScreenToLandscape() =>
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);


double getY(int zone) {
  double dy = PreferenceUtils.getDouble('zone${zone}Y', 1);
  return dy;
}

double getX(int zone) {
  double dx = PreferenceUtils.getDouble('zone${zone}X', 1);
  return dx;
}

/// Convert rssi value in dBm to an integer between 0 and 100
int levelToProgress(int level) {
  if (level > -30 && level <= -20)
    return 100;
  else if (level > -40 && level <= -30)
    return 90;
  else if (level > -50 && level <= -40)
    return 80;
  else if (level > -55 && level <= -50)
    return 70;
  else if (level > -60 && level <= -55)
    return 60;
  else if (level > -65 && level <= -60)
    return 50;
  else if (level > -70 && level <= -65)
    return 40;
  else if (level > -80 && level <= -70)
    return 30;
  else if (level > -90 && level <= -80)
    return 20;
  else
    return 10;
}

Color backgroundColorBasedOnLevel(int level) {
  if (level > -50)
    return colors.excellentSignalLight;
  else if (level <= -50 && level > -60)
    return colors.goodSignalLight;
  else if (level <= -60 && level > -70)
    return colors.fairSignalLight;
  else
    return colors.weakSignalLight;
}

Color progressColorBasedOnLevel(int level) {
  if (level > -50)
    return colors.excellentSignal;
  else if (level <= -50 && level > -60)
    return colors.goodSignal;
  else if (level <= -60 && level > -70)
    return colors.fairSignal;
  else
    return colors.weakSignal;
}
