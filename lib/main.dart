import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_with_me/ui/home_screen.dart';

void main() {
  runApp(MaterialApp(
    title: "Example 1 Navigate to other",
    home: SplashScreen(),
  ));
}
class SplashScreen extends StatefulWidget{
  @override
  _SplashScreenState createState() => new _SplashScreenState();

}
class _SplashScreenState extends State<SplashScreen> {

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context)=>
          HomeScreen()
        ));
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
            "INI SPLASH SCREEN")
        ,
      ),
    );
  }
}