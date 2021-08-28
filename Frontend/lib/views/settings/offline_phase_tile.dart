import 'package:flutter/material.dart';

import '../../utils/color_utils.dart' as colors;
import '../../utils/preferences_util.dart';
import '../../utils/string_utils.dart' as strings;
import '../widgets/my_expansion_tile.dart';
import '../widgets/my_icons.dart' as icons;
import '../widgets/my_tile_icon.dart';

import 'slider.dart';

class OfflinePhaseTile extends StatefulWidget {
  @override
  _OfflinePhaseTileState createState() => _OfflinePhaseTileState();
}

class _OfflinePhaseTileState extends State<OfflinePhaseTile> {
  int _totalTime = 0;
  int _intervalTime = 0;

  @override
  void initState() {
    _loadSharedPreferences();
    super.initState();
  }

  _loadSharedPreferences() async {
    _totalTime = PreferenceUtils.getInt(strings.scanTime, 20);
    _intervalTime = PreferenceUtils.getInt(strings.intervalTime, 1000);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MyExpansionTile(
        title: strings.offlinePhase,
        subtitle: strings.offlinePhaseTile,
        leadingIcon: TileLeadingIcon(iconData: icons.tune),
        accentColor: colors.accentColor,
        childrenWidgets: [
          _sliderContainer(width, height, strings.t, 1, 20, 10,
              strings.scanTime, _totalTime),
          Divider(
              color: colors.grey, indent: width / 20, endIndent: width / 20),
          _sliderContainer(width, height, strings.d, 500, 3000, 5,
              strings.intervalTime, _intervalTime)
        ]);
  }

  Widget _sliderContainer(double width, double height, String title, double min,
      double max, int division, String key, int value) {
    return Container(
        alignment: Alignment.center,
        height: height / 12,
        margin: EdgeInsets.symmetric(horizontal: width / 20),
        color: colors.primaryColorLight,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
             _sliderTitleContainer(title, width),
             Expanded(
              flex: 1,
              child: SettingsSlider(
                  max: max,
                  min: min,
                  division: division,
                  value: value,
                  sharedPreferencesKey: key))
        ]));
  }

  Widget _sliderTitleContainer(String title, double width) {
    return Container(
        width: width / 12,
        height: width / 12,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: colors.primaryColor, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Text(title,
            style: TextStyle(
                color: colors.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold)));
  }
}
