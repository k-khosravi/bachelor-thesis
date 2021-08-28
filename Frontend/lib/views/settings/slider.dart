import 'package:flutter/material.dart';

import '../../utils/color_utils.dart' as colors;
import '../../utils/preferences_util.dart';

// ignore: must_be_immutable
class SettingsSlider extends StatefulWidget {
  double min;
  double max;
  int division;
  int value;
  String sharedPreferencesKey;

  SettingsSlider(
      {required this.min,
      required this.max,
      required this.division,
      required this.value,
      required this.sharedPreferencesKey});

  @override
  _SettingsSliderState createState() => _SettingsSliderState();
}

class _SettingsSliderState extends State<SettingsSlider> {
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
        data: SliderTheme.of(context).copyWith(
            activeTickMarkColor: colors.accentColor,
            inactiveTickMarkColor: colors.sliderInactiveTickMark,
            valueIndicatorColor: colors.primaryColor,
            activeTrackColor: colors.sliderActiveTrack,
            inactiveTrackColor: colors.primaryColor,
            thumbColor: colors.sliderThumbColor,
            showValueIndicator: ShowValueIndicator.always,
            valueIndicatorTextStyle: TextStyle(color: colors.primaryColorDark)),
        child: Slider(
            min: widget.min,
            max: widget.max,
            divisions: widget.division,
            value: widget.value.toDouble(),
            label: '${widget.value}',
            onChanged: (double newValue) {
              setState(() {
                widget.value = newValue.toInt();
                _saveToPrefs(widget.value);
              });
            }));
  }

  _saveToPrefs(int value) async =>
      PreferenceUtils.setInt(widget.sharedPreferencesKey, value);
}
