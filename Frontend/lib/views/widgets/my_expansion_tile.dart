import 'package:flutter/material.dart';

import '../../utils/color_utils.dart' as colors;

class MyExpansionTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final Widget leadingIcon;
  final Color accentColor;
  final List<Widget> childrenWidgets;

  MyExpansionTile({
    required this.title,
    required this.subtitle,
    required this.leadingIcon,
    required this.accentColor,
    required this.childrenWidgets,
  });

  @override
  _MyExpansionTileState createState() => _MyExpansionTileState();
}

class _MyExpansionTileState extends State<MyExpansionTile> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return _body(context, width, height);
  }

  Widget _body(BuildContext context, double width, double height) {
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: colors.primaryColorLight,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Theme(
            data: Theme.of(context).copyWith(
                accentColor: widget.accentColor,
                unselectedWidgetColor: colors.primaryColor,
                dividerColor: Colors.transparent),
            child: ExpansionTile(
                title: _titleText(),
                subtitle: _subtitleText(),
                leading: widget.leadingIcon,
                initiallyExpanded: true,
                children: widget.childrenWidgets,
                childrenPadding: EdgeInsets.symmetric(vertical: height / 100),
                expandedAlignment: Alignment.center,
                expandedCrossAxisAlignment: CrossAxisAlignment.start)));
  }

  Widget _titleText() {
    return Text(widget.title,
        style: TextStyle(
            color: colors.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20));
  }

  Widget _subtitleText() {
    return Text(widget.subtitle,
        style: TextStyle(color: colors.grey, fontSize: 14));
  }
}
