import 'package:flutter/material.dart';

import '../../utils/color_utils.dart' as colors;
import '../../utils/helper.dart' as helper;
import '../../utils/string_utils.dart' as strings;

import 'data_collection_content.dart';

class DataCollectionDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: colors.alertDialogBackground,
        insetPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: colors.accentDarkColor, width: 2),
            borderRadius: BorderRadius.circular(10)),
        title: _titleText(),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          DataCollectionContent(),
        ]),
        actions: <Widget>[_okButton(context)]);
  }

  Widget _titleText() {
    return Text(strings.addLocation,
        style: TextStyle(color: colors.accentDarkColor, fontSize: 18));
  }

  Widget _okButton(BuildContext context) {
    return TextButton(
        child:
            Text(strings.ok, style: TextStyle(color: colors.accentDarkColor)),
        onPressed: () {
          Navigator.of(context).pop();
          helper.changeScreenToLandscape();
        });
  }
}
