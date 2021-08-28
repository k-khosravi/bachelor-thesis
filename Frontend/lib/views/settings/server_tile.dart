import 'package:flutter/material.dart';

import '../../utils/color_utils.dart' as colors;
import '../../utils/string_utils.dart' as strings;
import '../widgets/my_expansion_tile.dart';
import '../widgets/my_icons.dart' as icons;
import '../widgets/my_text_field.dart';
import '../widgets/my_tile_icon.dart';

class ServerTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return MyExpansionTile(
        title: strings.server,
        subtitle: strings.serverTile,
        leadingIcon: TileLeadingIcon(iconData: icons.database),
        accentColor: colors.accentColor,
        childrenWidgets: [
          Container(
              margin: EdgeInsets.symmetric(
                  horizontal: width / 20, vertical: width / 40),
              child: MyTextField(
                  sharedPrefKey: strings.ipAddress,
                  defaultValue: strings.defaultIpAddress,
                  errorText: strings.checkInput,
                  labelText: strings.ipAddressTitle,
                  textColor: colors.primaryColor,
                  cursorColor: colors.grey,
                  enableColor: colors.accentColor,
                  disableColor: Colors.transparent,
                  focusedColor: colors.accentColor,
                  errorColor: colors.error,
                  contentPadding: width / 20,
                  isIP: true)),
          Container(
              margin: EdgeInsets.symmetric(
                  horizontal: width / 20, vertical: width / 40),
              child: MyTextField(
                  sharedPrefKey: strings.port,
                  defaultValue: strings.defaultPort,
                  errorText: strings.checkInput,
                  labelText: strings.portTitle,
                  textColor: colors.primaryColor,
                  cursorColor: colors.grey,
                  enableColor: colors.accentColor,
                  disableColor: Colors.transparent,
                  focusedColor: colors.accentColor,
                  errorColor: colors.error,
                  contentPadding: width / 20,
                  isIP: false))
        ]);
  }
}
