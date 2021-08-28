import 'package:flutter/material.dart';

import '../../utils/color_utils.dart' as colors;
import '../../utils/string_utils.dart' as strings;
import '../widgets/my_icons.dart' as icons;

import 'offline_phase_tile.dart';
import 'server_tile.dart';
import 'wifi_tile.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(appBar: _appBar(), body: _body(height));
  }

  AppBar _appBar() {
    return AppBar(
        title: Text(strings.settings,
            style: TextStyle(color: colors.primaryColor)),
        leading: IconButton(
          icon: Icon(icons.backArrow, color: colors.primaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ));
  }

  Widget _body(double height) {
    return CustomScrollView(slivers: [
      SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height / 40),
                WifiTile(),
                SizedBox(height: height / 40),
                OfflinePhaseTile(),
                SizedBox(height: height / 40),
                ServerTile()
              ]))
    ]);
  }
}
