import 'package:flutter/material.dart';

import '../../utils/assets_urls.dart' as assets;
import '../../utils/color_utils.dart' as colors;
import '../../utils/helper.dart' as helper;
import '../../utils/string_utils.dart' as strings;

class WifiInfoDialog extends StatelessWidget {
  final Color iconColor;
  final String ssid;
  final String bssid;
  final String band;
  final String signal;
  final String channel;

  WifiInfoDialog({
    required this.iconColor,
    required this.ssid,
    required this.bssid,
    required this.band,
    required this.signal,
    required this.channel,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return _infoDialog(width, height, context);
  }

  Widget _infoDialog(double width, double height, BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(10),
        child: Container(
            width: double.infinity,
            height: height / 2,
            padding: EdgeInsets.symmetric(horizontal: width / 100),
            decoration: BoxDecoration(
              color: colors.primaryColorLight,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
            ),
            child: _infoContainer(width, height, context)));
  }

  Widget _infoContainer(double width, double height, BuildContext context) {
    const List<String> _titles = [
      strings.ssid,
      strings.bssid,
      strings.band,
      strings.signal,
      strings.channel
    ];
    List<String> _values = [
      ssid,
      bssid,
      '${helper.getChannel(band)} GHz',
      '$signal dBm',
      'Ch #$channel($band MHz)'
    ];

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: width / 50),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _wifiIconContainer(width, height),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                _customColumn(_titles, iconColor, true, height),
                _customColumn(_values, colors.grey, false, height)
              ]),
              _closeButtonContainer(context)
            ]));
  }

  Widget _wifiIconContainer(double width, double height) {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: height / 100),
        child: ColorFiltered(
            child: Image.asset(assets.wifiSignal,
                width: width / 5, height: width / 5, fit: BoxFit.cover),
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn)));
  }

  Widget _customColumn(
      List<String> itemText, Color textColor, bool isLeading, double height) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment:
            isLeading ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          _titleText(itemText[0], textColor),
          SizedBox(height: height / 50),
          _titleText(itemText[1], textColor),
          SizedBox(height: height / 50),
          _titleText(itemText[2], textColor),
          SizedBox(height: height / 50),
          _titleText(itemText[3], textColor),
          SizedBox(height: height / 50),
          _titleText(itemText[4], textColor)
        ]);
  }

  Widget _titleText(String title, Color textColor) {
    return Text(title,
        maxLines: 1, style: TextStyle(color: textColor, fontSize: 18));
  }

  Widget _closeButtonContainer(BuildContext context) {
    return Align(
        alignment: Alignment.bottomRight,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.transparent, shadowColor: Colors.transparent),
            onPressed: () => Navigator.of(context).pop(),
            child: Text(strings.close,
                style: TextStyle(fontSize: 18, color: iconColor))));
  }
}
