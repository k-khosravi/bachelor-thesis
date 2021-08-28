import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

import '../../utils/color_utils.dart' as colors;

class CircularTimer extends StatelessWidget {
  final int duration;
  final CountDownController controller;
  final Function startTimer;
  final Function completeTimer;

  CircularTimer(
      {required this.duration,
      required this.controller,
      required this.startTimer,
      required this.completeTimer});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return CircularCountDownTimer(
        onStart: () => startTimer(),
        onComplete: () => completeTimer(),
        duration: duration,
        initialDuration: 0,
        controller: controller,
        width: width * 2 / 5,
        height: height / 3,
        ringColor: colors.timerRingColor,
        textFormat: CountdownTextFormat.S,
        fillColor: colors.timerFill,
        fillGradient: null,
        backgroundColor: colors.backgroundColor,
        strokeWidth: 20.0,
        strokeCap: StrokeCap.round,
        isReverse: false,
        isReverseAnimation: false,
        isTimerTextShown: true,
        autoStart: false,
        ringGradient: LinearGradient(
            colors: [colors.timerRingGradient1, colors.timerRingGradient2]),
        textStyle: TextStyle(
            fontSize: 40.0,
            color: colors.primaryColor,
            fontWeight: FontWeight.bold));
  }
}
