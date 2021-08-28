import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/color_utils.dart' as colors;
import '../../utils/preferences_util.dart';

class MyTextField extends StatefulWidget {
  String sharedPrefKey;
  String defaultValue;
  String errorText;
  String labelText;
  Color textColor;
  Color cursorColor;
  Color enableColor;
  Color disableColor;
  Color focusedColor;
  Color errorColor;
  double contentPadding;
  bool isIP;

  MyTextField(
      {required this.sharedPrefKey,
      required this.defaultValue,
      required this.errorText,
      required this.labelText,
      required this.textColor,
      required this.cursorColor,
      required this.enableColor,
      required this.disableColor,
      required this.focusedColor,
      required this.errorColor,
      required this.contentPadding,
      required this.isIP});

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  String _sharedPrefValue = '';
  late TextEditingController _controller;
  bool isValid = true;

  @override
  void initState() {
    super.initState();
    _loadSharedPref();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: _controller,
        cursorColor: widget.cursorColor,
        keyboardType:
            TextInputType.numberWithOptions(decimal: true, signed: false),
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(horizontal: widget.contentPadding),
          disabledBorder: _coloredBorder(widget.disableColor),
          enabledBorder: _coloredBorder(widget.enableColor),
          errorBorder: _coloredBorder(widget.errorColor),
          errorText: isValid ? null : widget.errorText,
          errorStyle: _textStyle(widget.errorColor),
          focusedBorder: _coloredBorder(widget.focusedColor),
          focusedErrorBorder: _coloredBorder(widget.errorColor),
          hintStyle: _textStyle(colors.grey),
          hintText: widget.defaultValue,
          labelStyle: _textStyle(widget.enableColor),
          labelText: widget.labelText,
        ),
        style: _textStyle(widget.textColor),
        inputFormatters: widget.isIP
            ? null
            : <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
        onEditingComplete: () {
          setState(() {
            _sharedPrefValue = _controller.text;
            _saveToPref(_sharedPrefValue);
          });
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        });
  }

  InputBorder _coloredBorder(Color color) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide:
            BorderSide(width: 1, style: BorderStyle.solid, color: color));
  }

  TextStyle _textStyle(Color color) => TextStyle(color: color, fontSize: 16);

  _loadSharedPref() async {
    String result =
        PreferenceUtils.getString(widget.sharedPrefKey, widget.defaultValue);
    setState(() {
      _sharedPrefValue = result;
      _controller = TextEditingController(text: result);
    });
  }

  _saveToPref(String value) async =>
      PreferenceUtils.setString(widget.sharedPrefKey, value);
}
