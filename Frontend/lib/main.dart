import 'package:find_me/utils/color_utils.dart' as colors;
import 'package:find_me/utils/string_utils.dart' as strings;
import 'package:find_me/views/home/home_screen.dart';
import 'package:find_me/views/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        title: strings.appTitle,
        theme: new ThemeData(
            scaffoldBackgroundColor: colors.backgroundColor,
            appBarTheme: AppBarTheme(backgroundColor: colors.appBar),
            primaryColor: colors.primaryColor,
            primaryColorLight: colors.primaryColorLight,
            primaryColorDark: colors.primaryColorDark,
            accentColor: colors.accentColor,
            backgroundColor: colors.backgroundColor,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        routes: {
          '/home': (context) => new Home(),
          '/splash': (context) => new Splash()
        },
        home: Splash());
  }
}
