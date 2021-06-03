import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_app/pages/player_page.dart';
import 'package:music_app/theme.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: backgroundColor,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness:Brightness.dark,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PlayerPage(),
    );
  }
}
