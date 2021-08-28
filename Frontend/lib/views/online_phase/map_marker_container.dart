import 'package:flutter/material.dart';

import '../../utils/color_utils.dart' as colors;
import '../widgets/map_marker.dart';

class MapMarkerContainer extends StatelessWidget {
  final double xOffset;
  final double yOffset;
  final double xCoordinate;
  final double yCoordinate;

  MapMarkerContainer(
      {required this.xOffset,
      required this.yOffset,
      required this.xCoordinate,
      required this.yCoordinate});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Positioned(
        top: xOffset  - 35, left: yOffset, child: _positionContainer(width, height));
  }

  Widget _positionContainer(double width, double height) {
    return Column(
      children: [
        _coordinateContainer(),
        SizedBox(height: 10),
        MapMarker()
      ],
    );
  }

  Widget _coordinateContainer() {
    return Container(
        height: 25,
        padding: EdgeInsets.symmetric(horizontal: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: colors.mapMarker,
            border: Border.all(color: colors.black, width: 1),
            borderRadius: BorderRadius.circular(10)),
        child: _text("($xCoordinate, $yCoordinate)"));
  }

  Widget _text(String value) {
    return Text(
      value,
      style: TextStyle(
          color: colors.primaryColor, fontSize: 10, fontWeight: FontWeight.bold),
    );
  }
}
