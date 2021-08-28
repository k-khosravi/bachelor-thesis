import 'package:flutter/material.dart';

import '../../utils/assets_urls.dart' as assets;
import '../../utils/helper.dart' as helper;


class FloorMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          helper.changeScreenToPortrait();
          Navigator.pop(context, false);
          return Future.value(false);
        },
        child: Center(
            child: InteractiveViewer(
                panEnabled: false,
                alignPanAxis: false,
                minScale: 1,
                maxScale: 2,
                child: Image.asset(assets.floorMap, fit: BoxFit.fill))));
  }
}
