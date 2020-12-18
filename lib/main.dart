import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:weather_with_me/ui/home_screen.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'Overpass'),
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [HexColor("#47BFDF"), HexColor("#4A91FF")],
                begin: const FractionalOffset(0.5, 0.0),
                end: const FractionalOffset(0.0, 0.5),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp)),
        child: Center(
          child: Image(image: AssetImage('assets/sun_cloudy.png'),width: 150,height: 150),
        ),
      )
    );
  }
}