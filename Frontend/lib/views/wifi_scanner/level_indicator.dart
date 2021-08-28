import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class WifiLevelIndicator extends StatelessWidget {
  final int progress;
  final Color backgroundColor;
  final Color progressColor;

  WifiLevelIndicator(
      {required this.progress,
      required this.backgroundColor,
      required this.progressColor});

  @override
  Widget build(BuildContext context) {
    return FAProgressBar(
        currentValue: progress,
        maxValue: 100,
        direction: Axis.vertical,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        backgroundColor: backgroundColor,
        progressColor: progressColor,
        size: 10,
        animatedDuration: const Duration(milliseconds: 300),
        verticalDirection: VerticalDirection.up);
  }
}
