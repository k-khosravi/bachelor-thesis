import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wifi_plugin/wifi_plugin.dart';

import '../../api/api.dart';
import '../../api/api_result.dart';
import '../../models/point.dart';
import '../../utils/color_utils.dart' as colors;
import '../../utils/helper.dart' as helper;
import '../../utils/preferences_util.dart';
import '../../utils/string_utils.dart' as strings;
import '../offline_phase/circular_timer.dart';
import '../offline_phase/minus_button.dart';
import '../offline_phase/plus_button.dart';
import '../widgets/my_icons.dart' as icons;
import '../widgets/my_snack_bar.dart' as snackBar;

import 'coordinate_text_field.dart';

class DataCollectionContent extends StatefulWidget {
  @override
  _DataCollectionContentState createState() => _DataCollectionContentState();
}

class _DataCollectionContentState extends State<DataCollectionContent> {
  final CountDownController _controller = CountDownController();
  int _duration = 0, _intervalTime = 0, _xValue = 0, _yValue = 0, index = 0;
  String _ipAddress = '', _port = '', _url = '';
  bool _isStopped = false;
  var _sampleTime;
  late Timer _timer;
  List<AccessPoint> _accessPointsList = [];
  Map<dynamic, dynamic> _accessPointsMap = {};

  @override
  void initState() {
    helper.changeScreenToPortrait();
    _initVariables();
    super.initState();
  }

  _initVariables() {
    _duration = PreferenceUtils.getInt(strings.scanTime, 20);
    _intervalTime = PreferenceUtils.getInt(strings.intervalTime, 1000);
    _sampleTime = Duration(milliseconds: _intervalTime);
    _ipAddress = PreferenceUtils.getString(strings.ipAddress, strings.defaultIpAddress);
    _port = PreferenceUtils.getString(strings.port, strings.defaultPort);
    _url = 'http://' + _ipAddress + ':' + _port + '/api/v1/fingerprint';
    Wifi.setRssiListSize(_duration);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height * 2 / 3;
    return _body(height, width);
  }

  Widget _body(double width, double height) {
    return Center(
        child: Container(
            color: colors.backgroundColor,
            height: height,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap: _resetTimer,
                      child: CircularTimer(
                          duration: _duration,
                          controller: _controller,
                          startTimer: _startTimer,
                          completeTimer: _completeTimer)),
                  SizedBox(height: height / 20),
                  _coordinateContainer(height, true),
                  SizedBox(height: height / 20),
                  _coordinateContainer(height, false)
                ])));
  }

  Widget _coordinateContainer(double height, bool isX) {
    return Container(
        height: height / 8,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          MinusButton(
            icon: icons.minus,
            callBack: (val) =>
                setState(() => isX ? _xValue += val : _yValue += val),
          ),
          isX
              ? CoordinateTextField(
                  text: _xValue.toString(), labelText: strings.x)
              : CoordinateTextField(
                  text: _yValue.toString(), labelText: strings.y),
          PlusButton(
              icon: icons.plus,
              callBack: (val) =>
                  setState(() => isX ? _xValue += val : _yValue += val)),
        ]));
  }

  _collectAccessPoints() async {
    var result = await Wifi.getAccessPoints(index);
    setState(() => _accessPointsMap = result);
  }

  _filterData() {
    List<AccessPoint> _list = [];
    for (MapEntry mapEntry in _accessPointsMap.entries) {
      String bssid = mapEntry.key;
      List<int> rssiList = List.of(mapEntry.value).cast<int>();
      AccessPoint _accessPoint = AccessPoint(bssid: bssid, rssiList: rssiList);
      _list.add(_accessPoint);
    }
    setState(() => _accessPointsList = _list);
  }

  _postData() async {
    Point newPoint = Point(
        xCoordinate: _xValue,
        yCoordinate: _yValue,
        totalScanTime: _duration,
        intervalTime: _intervalTime ~/ 1000,
        dateTime: helper.dateTime,
        accessPoints: _accessPointsList);
    APIResult response = await API.offlinePhaseAPI.postPoints(_url, newPoint);
    if (response.isSuccessful()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar.infoMessage(strings.postedSuccessfully));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar.infoMessage(strings.serverError));
    }
  }

  _startTimer() {
    _timer = new Timer.periodic(_sampleTime, (Timer timer) {
      if (_isStopped == false) {
        _collectAccessPoints();
        Wifi.requestNewScan(false);
        setState(() => index = index + 1);
      } else
        timer.cancel();
    });
  }

  _completeTimer() {
    _filterData();
    _postData();
    setState(() => _resetVariables());
  }

  _resetTimer() {
    Wifi.requestNewScan(true);
    setState(() {
      _isStopped = false;
      _controller.restart();
    });
  }

  _resetVariables() {
    _isStopped = true;
    _timer.cancel();
    _accessPointsList = [];
    _accessPointsMap = {};
    index = 0;
  }
}
