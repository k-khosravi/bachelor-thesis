import 'package:flutter/material.dart';

import '../../utils/color_utils.dart' as colors;
import '../../utils/helper.dart' as helper;
import '../../utils/preferences_util.dart';
import '../offline_phase/data_collection_dialog.dart';
import '../widgets/floor_map.dart';
import '../widgets/map_marker.dart';

class OfflinePhaseScreen extends StatefulWidget {
  @override
  _OfflinePhaseScreenState createState() => _OfflinePhaseScreenState();
}

class _OfflinePhaseScreenState extends State<OfflinePhaseScreen> {
  Map<String, double> coordination = {};
  Offset _offset = Offset(100, 100);
  int counter = 0;

  @override
  void initState() {
    helper.changeScreenToLandscape();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _body());
  }

  Widget _body() {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
          color: colors.primaryColor,
          child:
              Stack(children: [FloorMap(), mapMarkerContainer(constraints)]));
    });
  }

  Widget mapMarkerContainer(BoxConstraints constraints) {
    return Positioned(
        top: _offset.dx,
        left: _offset.dy,
        child: Draggable(
            child: MapMarker(),
            childWhenDragging: Container(),
            feedback: MapMarker(),
            onDragEnd: (details) => _onDragEnd(details, constraints)));
  }

  Future<void> _showDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => DataCollectionDialog());
  }

  _onDragEnd(DraggableDetails details, BoxConstraints constraints) {
    setState(() {
      final adjustment =
          MediaQuery.of(context).size.width - constraints.maxWidth;
      _offset = Offset(details.offset.dy - adjustment, details.offset.dx);
      counter = counter + 1;
      PreferenceUtils.setDouble("zone${counter}X", _offset.dx);
      PreferenceUtils.setDouble("zone${counter}Y", _offset.dy);
    });
    _showDialog();
  }
}
