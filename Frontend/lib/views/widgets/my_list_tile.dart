import 'package:flutter/material.dart';

import '../../utils/color_utils.dart' as colors;

class MyListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget leadingIcon;
  final Widget trailingWidget;

  MyListTile({
    required this.title,
    required this.subtitle,
    required this.leadingIcon,
    required this.trailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return _body(width, height);
  }

  Widget _body(double width, double height) {
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: colors.primaryColorLight,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: ListTile(
            title: _titleText(),
            subtitle: _subtitleText(),
            leading: leadingIcon,
            trailing: trailingWidget,
            contentPadding: EdgeInsets.symmetric(horizontal: width / 20)));
  }

  Widget _titleText() {
    return Text(title,
        style: TextStyle(
            color: colors.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20));
  }

  Widget _subtitleText() {
    return Text(subtitle, style: TextStyle(color: colors.grey, fontSize: 14));
  }
}
