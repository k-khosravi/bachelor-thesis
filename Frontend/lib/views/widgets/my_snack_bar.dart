import 'package:flutter/material.dart';

import '../../utils/color_utils.dart' as colors;

SnackBar infoMessage(String message) {
  return SnackBar(
      content: Text(message,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
          style: const TextStyle(
              color: colors.accentColor,
              fontSize: 14,
              fontWeight: FontWeight.bold)),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      backgroundColor: colors.primaryColorLight,
      elevation: 0,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(0));
}
