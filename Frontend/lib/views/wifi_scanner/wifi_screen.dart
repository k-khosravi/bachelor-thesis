import 'package:flutter/material.dart';
import 'package:wifi_plugin/wifi_plugin.dart';

import '../../utils/color_utils.dart' as colors;
import '../../utils/string_utils.dart' as strings;
import '../widgets/my_icons.dart' as icons;
import 'wifi_card.dart';

class WiFiScanner extends StatefulWidget {
  @override
  _WiFiScannerState createState() => _WiFiScannerState();
}

class _WiFiScannerState extends State<WiFiScanner> {
  List<dynamic> _wifiList = [];

  @override
  void initState() {
    fetchAccessPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(appBar: _appbar(), body: _buildList(height, width));
  }

  AppBar _appbar() {
    return AppBar(
        title: Text(strings.wifiScanner,
            style: TextStyle(color: colors.primaryColor)),
        leading: IconButton(
            icon: Icon(icons.backArrow, color: colors.primaryColor),
            onPressed: () => Navigator.of(context).pop()));
  }

  Widget _buildList(height, width) {
    return Container(
      child: _wifiList.length != 0
          ? RefreshIndicator(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: _wifiList.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return WiFiCard(wifi: _wifiList.elementAt(index));
                  }),
              onRefresh: _getAccessPoints)
          : Center(child: CircularProgressIndicator()),
    );
  }

  fetchAccessPoints() async {
    var result = await Wifi.wifiScanner;
    setState(() => _wifiList = result);
  }

  Future<void> _getAccessPoints() async => setState(() => fetchAccessPoints());
}
