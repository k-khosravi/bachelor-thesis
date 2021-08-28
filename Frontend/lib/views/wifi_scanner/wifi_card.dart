import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../utils/color_utils.dart' as colors;
import '../../utils/helper.dart' as helper;
import '../../utils/string_utils.dart' as strings;
import '../widgets/my_icons.dart' as icons;
import 'level_indicator.dart';
import 'wifi_info_dialog.dart';

class WiFiCard extends StatelessWidget {
  final double elevation;
  final dynamic wifi;

  WiFiCard({this.elevation = 8, required this.wifi});

  @override
  Widget build(BuildContext context) {
    String ssid = wifi[strings.ssid];
    String bssid = wifi[strings.bssid];
    String rssi = wifi[strings.rssi];
    int level = int.parse(rssi);
    String freq = wifi[strings.frequency];
    String channel = wifi[strings.channel];
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return _wifiItemCard(
        ssid, bssid, rssi, freq, channel, level, width, height, context);
  }

  Widget _wifiItemCard(
      String ssid,
      String bssid,
      String rssi,
      String frequency,
      String channel,
      int level,
      double width,
      double height,
      BuildContext context) {
    return ListTile(
        tileColor: colors.primaryColorLight,
        title: _wifiInfoTopSection(ssid, bssid, level, width, height),
        subtitle:
            _wifiInfoBottomSection(frequency, channel, rssi, height, width),
        contentPadding: EdgeInsets.symmetric(horizontal: width / 20),
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return WifiInfoDialog(
                    iconColor: helper.progressColorBasedOnLevel(level),
                    ssid: ssid,
                    bssid: bssid,
                    band: frequency,
                    signal: rssi,
                    channel: channel);
              });
        });
  }

  Widget _ssidText(String ssid, double height) {
    return Text(ssid,
        maxLines: 1,
        style: TextStyle(
            color: colors.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20));
  }

  Widget _bssidText(String bssid, double height) {
    return Text(bssid,
        maxLines: 1,
        style: TextStyle(color: colors.primaryColor, fontSize: 15));
  }

  Widget _wifiInfoTopSection(
      String ssid, String bssid, int level, double width, double height) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: height / 100),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                _ssidText(ssid, height),
                SizedBox(height: height / 50),
                _bssidText(bssid, height)
              ]),
              SizedBox(
                  width: 10,
                  height: height / 10,
                  child: WifiLevelIndicator(
                      progress: helper.levelToProgress(level),
                      backgroundColor:
                          helper.backgroundColorBasedOnLevel(level),
                      progressColor: helper.progressColorBasedOnLevel(level)))
            ]));
  }

  Widget _wifiInfoBottomSection(String frequency, String channel, String rssi,
      double height, double width) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: EdgeInsets.symmetric(vertical: height / 100),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                _wifiFeatureContainer(
                helper.getChannel(frequency) + strings.gigaHertz,
                icons.antenna,
                width,
                height),
                _wifiFeatureContainer(
                strings.ch + channel, icons.remote, width, height),
                _wifiFeatureContainer(
                rssi + strings.dbm, icons.equalizer, width, height),
                SizedBox()
          ])),
      Divider(color: colors.primaryColor)
    ]);
  }

  Widget _wifiFeatureContainer(
      String title, IconData icon, double width, double height) {
    return Container(
        padding: EdgeInsets.symmetric(
            vertical: height / 100, horizontal: width / 40),
        decoration: BoxDecoration(
            color: colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(title,
              style: TextStyle(fontSize: 15, color: colors.primaryColor)),
          SizedBox(width: width / 40),
          Icon(icon, size: 20, color: colors.primaryColor) // Icon(MdiIcons)
        ]));
  }
}
