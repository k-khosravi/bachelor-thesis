import 'package:flutter/material.dart';
import 'package:wifi_plugin/wifi_plugin.dart';

import '../../api/api.dart';
import '../../api/api_result.dart';
import '../../utils/color_utils.dart' as colors;
import '../../utils/helper.dart' as helper;
import '../../utils/preferences_util.dart';
import '../../utils/string_utils.dart' as strings;
import '../online_phase/map_marker_container.dart';
import '../widgets/floor_map.dart';
import '../widgets/my_icons.dart' as icons;
import '../widgets/my_snack_bar.dart' as snackBar;

class OnlinePhase extends StatefulWidget {
  @override
  _OnlinePhaseState createState() => _OnlinePhaseState();
}

class _OnlinePhaseState extends State<OnlinePhase> {
  int  _zoneNumber = 1;
  double _xCoordinate = 0, _yCoordinate = 0, _xOffset = 100, _yOffset = 100;
  String _ipAddress = '', _port = '', _url = '';
  bool _visible = false;
  Map<String, int> _accessPointsMap = {};
  Map<dynamic, dynamic> _map = {};

  @override
  void initState() {
    helper.changeScreenToLandscape();
    _initVariables();
    _collectAccessPoints();
    super.initState();
  }

  _initVariables() {
    _ipAddress = PreferenceUtils.getString(strings.ipAddress, strings.defaultIpAddress);
    _port = PreferenceUtils.getString(strings.port, strings.defaultPort);
    _url = 'http://' + _ipAddress + ':' + _port + '/api/v1/fingerprint';
    Wifi.setRssiListSize(1);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(body: _body(width, height));
  }

  Widget _body(double width, double height) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
          color: colors.primaryColor,
          child: Stack(children: [
            FloorMap(),
            _navigationButton(),
            _visible
                ? MapMarkerContainer(
                    xOffset: _xOffset,
                    yOffset: _yOffset,
                    xCoordinate: _xCoordinate,
                    yCoordinate: _yCoordinate)
                : Container()
          ]));
    });
  }

  Widget _navigationButton() {
    return Align(
        alignment: Alignment.bottomRight,
        child: Container(
            child: IconButton(
                iconSize: 40,
                icon: Icon(icons.myLocation, color: colors.mapMarker),
                onPressed: () {
                  _collectAccessPoints();
                  _filterData();
                  _getPosition();
                })));
  }

  _collectAccessPoints() async {
    Wifi.requestNewScan(true);
    var result = await Wifi.getAccessPoints(0);
    setState(() => _map = result);
  }

  _filterData() {
    setState(() {
      for (MapEntry mapEntry in _map.entries) {
        String bssid = mapEntry.key;
        int rssi = List.of(mapEntry.value).cast<int>().first;
        _accessPointsMap[bssid] = rssi;
      }
    });
  }

  _getPosition() async {
    APIResult response = await API.onlinePhaseAPI.getLocation(_url, _accessPointsMap);
    if (response.isSuccessful()) {
      var data = response.data;
      setState(() {
        _zoneNumber = data[strings.zoneNumber];
        _xCoordinate = data[strings.x];
        _yCoordinate = data[strings.y];
        _xOffset = helper.getX(_zoneNumber);
        _yOffset = helper.getY(_zoneNumber);
        _visible = true;
      });
    } else
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar.infoMessage(strings.serverError));
  }
}
