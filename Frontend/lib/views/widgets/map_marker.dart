import 'package:flutter/material.dart';

import '../../utils/assets_urls.dart' as assets;

class MapMarker extends StatefulWidget {
  const MapMarker({Key? key}) : super(key: key);

  @override
  _MapMarkerState createState() => _MapMarkerState();
}

class _MapMarkerState extends State<MapMarker> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
        alignment: Alignment.center,
        child: Image.asset(assets.mapMarker,
            height: height / 8, fit: BoxFit.fitWidth));
  }
}

