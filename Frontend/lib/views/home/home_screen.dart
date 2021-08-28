import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../../utils/color_utils.dart' as colors;
import '../../utils/location_service.dart';
import '../../utils/preferences_util.dart';
import '../../utils/string_utils.dart' as strings;
import '../help/help_screen.dart';
import '../offline_phase/offline_phase_screen.dart';
import '../online_phase/online_phase_screen.dart';
import '../settings/settings_screen.dart';
import '../widgets/my_icons.dart' as icons;
import '../wifi_scanner/wifi_screen.dart';

import 'home_card.dart';
import 'logo_container.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    PreferenceUtils.init();
    _askLocationPermission();
    super.initState();
  }

  _askLocationPermission() {
    LocationService().checkPermissions().then((status) {
      if (status != PermissionStatus.granted)
        LocationService().requestPermission();
    });
    LocationService().checkService().then((status) {
      if (!status) LocationService().requestService();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(appBar: _appbar(), body: _body(width, height));
  }

  AppBar _appbar() {
    return AppBar(backgroundColor: colors.gradient1, actions: [
      IconButton(
          icon: Icon(icons.settings, color: colors.settingsIcon, size: 30),
          onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Settings()),
              ))
    ]);
  }

  Widget _body(double width, double height) {
    return SafeArea(
        child: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            colors.gradient1,
            colors.gradient2,
            colors.gradient3,
            colors.gradient4,
            colors.gradient5,
            colors.gradient6,
            colors.gradient7,
          ])),
      child: Column(
          children: [LogoContainer(), _dashboardContainer(width, height)]),
    ));
  }

  Widget _dashboardContainer(double width, double height) {
    return Container(
      height: height * 3 / 5,
      width: width * 4 / 5,
      margin: EdgeInsets.symmetric(horizontal: width / 10),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        _topRow(width, height),
        _dividerContainer(width, height),
        _bottomRow(width, height)
      ]),
    );
  }

  Widget _topRow(double width, double height) {
    return Container(
      height: width * 2 / 5 - height / 40,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        HomeCard(
            goToRoute: OfflinePhaseScreen(),
            titleText: strings.offlinePhase.toUpperCase(),
            icon: icons.place),
        _sizedBox(width, height),
        HomeCard(
            goToRoute: OnlinePhase(),
            titleText: strings.onlinePhase.toUpperCase(),
            icon: icons.personSearch)
      ]),
    );
  }

  Widget _dividerContainer(double width, double height) {
    return Container(
      width: width * 4 / 5,
      height: height / 20,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
            width: width * 2 / 5 - height / 40, child: _horizontalDivider()),
        SizedBox(width: height / 40, height: height / 40),
        SizedBox(
            width: width * 2 / 5 - height / 40, child: _horizontalDivider())
      ]),
    );
  }

  Widget _bottomRow(double width, double height) {
    return Container(
        height: width * 2 / 5 - height / 40,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          HomeCard(
              goToRoute: WiFiScanner(),
              titleText: strings.wifiScanner.toUpperCase(),
              icon: icons.wifi),
          _sizedBox(width, height),
          HomeCard(
              goToRoute: HelpScreen(),
              titleText: strings.help.toUpperCase(),
              icon: icons.help)
        ]));
  }

  Widget _sizedBox(double width, double height) {
    return SizedBox(
        width: height / 20,
        height: width * 2 / 5 - height / 40,
        child: _verticalDivider());
  }

  Widget _horizontalDivider() => Divider(color: colors.divider, thickness: 1);

  Widget _verticalDivider() =>
      VerticalDivider(color: colors.divider, thickness: 1);
}
