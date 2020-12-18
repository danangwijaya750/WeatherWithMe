import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:weather_with_me/bloc/weather_bloc.dart';
import 'package:weather_with_me/model/weather_model.dart';

import 'forecast_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenStateful createState() => _HomeScreenStateful();
}

class _HomeScreenStateful extends State<HomeScreen> {
  Position location;
  String address="Current Location";
  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    if (location != null) {
      weatherBloc.fetchWeatherData(
          location.latitude.toString(), location.longitude.toString());
    }
    return StreamBuilder(
      stream: weatherBloc.weather,
      builder: (context, AsyncSnapshot<WeatherModel> snapshot) {
        if (snapshot.hasData) {
          print("hahaha : " + snapshot.data.toString());
          return _buildHomeScreen(snapshot.data, context);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [HexColor("#47BFDF"), HexColor("#4A91FF")],
                    begin: const FractionalOffset(0.5, 0.0),
                    end: const FractionalOffset(0.0, 0.5),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp)),
            child: Center(
              child: CircularProgressIndicator(),
            ));
      },
    );
  }

  _buildHomeScreen(WeatherModel data, BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [HexColor("#47BFDF"), HexColor("#4A91FF")],
                    begin: const FractionalOffset(0.8, 0.0),
                    end: const FractionalOffset(0.0, 0.8),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 52, left: 34),
                  child: Text(
                    address,
                    style: TextStyle(
                        color: HexColor("#FFFFFF"),
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 60),
                    child: _showCurrentImage(data)),
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: _showCurrentData(data),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50,left: 120,right: 120),
                  child: ButtonTheme(
                    minWidth: 200,
                     height: 60,
                     child : RaisedButton(
                       color: HexColor("#FFFFFF"),
                        onPressed: ()=>{
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) => ForecastScreen(data: data,), ),
                        )
                        },
                        textColor: HexColor("#444E72"),
                        child: Text("Weather Forecast",style: TextStyle(fontSize: 18),),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                      )
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child:Center (
                    child:
                    Text(
                    "Data Provided By openweathermap.org"
                  ,style: TextStyle(color: Colors.white,fontSize: 15)),
                ))
              ],
            )));
  }

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  _showCurrentData(WeatherModel data){
    var date = new DateTime.fromMillisecondsSinceEpoch(data.current.dt * 1000);
    String day ="Today, "+DateFormat("MMMM dd").format(date);
    String suhu=data.current.temp.toString()+"\u00B0";
    String feelsLike=data.current.feelsLike.toString()+"\u00B0";
    print(day);
    return Container(
      margin: EdgeInsets.only(left: 50,right: 50),
      child: Column(
        children: [
         Container(
           margin: EdgeInsets.only(top:17),
             child: Text(
               day,style: TextStyle(color: HexColor("#FFFFFF"),fontSize: 18),)
         ),
          Container(
            margin: EdgeInsets.only(top: 14,bottom: 0),
            child:  Text(
              suhu,style: TextStyle(color: HexColor("#FFFFFF"),fontSize: 90)),
          ),
          Container(
            margin: EdgeInsets.only(top: 0),
            child:  Text(
              data.current.weather[0].main,style: TextStyle(color: HexColor("#FFFFFF"),fontSize: 24
                ,fontWeight: FontWeight.bold),),
          ),
          Container(
            margin: EdgeInsets.only(top: 0),
            child:  Text(
              data.current.weather[0].description,style: TextStyle(color: HexColor("#FFFFFF"),fontSize: 18
                ,),),
          ),
          Container(
            margin: EdgeInsets.only(top: 31,left: 50,right: 50),
            child: Row(
              children: [
                Image(image: AssetImage("assets/windy.png"),width: 20,height: 20,),
                Container(margin: EdgeInsets.only(left: 22), child: Text("Wind",style: TextStyle(color: HexColor("#FFFFFF"),fontSize: 18),),),
                Container(margin: EdgeInsets.only(left: 22), child: Text("|",style: TextStyle(color: HexColor("#FFFFFF"),fontSize: 18),),),
                Container(margin: EdgeInsets.only(left: 22), child: Text((data.current.windSpeed * 3.6).toString()+" km/h",style: TextStyle(color: HexColor("#FFFFFF"),fontSize: 18),),)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 23,left: 50,right: 50),
            child: Row(
              children: [
                Image(image: AssetImage("assets/hum.png"),width: 20,height: 20,),
                Container(margin: EdgeInsets.only(left: 22), child: Text("Hum",style: TextStyle(color: HexColor("#FFFFFF"),fontSize: 18),),),
                Container(margin: EdgeInsets.only(left: 22), child: Text("|",style: TextStyle(color: HexColor("#FFFFFF"),fontSize: 18),),),
                Container(margin: EdgeInsets.only(left: 22), child: Text(data.current.humidity.toString()+" %",style: TextStyle(color: HexColor("#FFFFFF"),fontSize: 18),),)
              ],
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: HexColor("#FFFFFF").withOpacity(0.3),
      ),
      height: 300,
    );
  }

  _showCurrentImage(WeatherModel data) {
    var date = new DateTime.fromMillisecondsSinceEpoch(data.current.dt * 1000);
    String ampm = DateFormat("HH").format(date);
    print(DateFormat("yyyy-MM-dd HH-mm-ss").format(date));
    if (data.current.weather[0].main == "Clear") {
      if (int.parse(ampm) >= 18|| int.parse(ampm)<5) {
        return Image(image: AssetImage('assets/moon.png'),width: 150,height: 150);
      } else {
        return Image(image: AssetImage('assets/sunny.png'),width: 150,height: 150);
      }
    } else if (data.current.weather[0].main == "Rain") {
      return Image(image: AssetImage('assets/rain.png'),width: 150,height: 150);
    } else if (data.current.weather[0].main == "Thunderstorm") {
      return Image(image: AssetImage('assets/thunder.png'),width: 150,height: 150);
    } else if (data.current.weather[0].main == "Clouds") {
      if (int.parse(ampm) >= 18|| int.parse(ampm)<5) {
        return Image(image: AssetImage('assets/moon_cloudy.png'),width: 150,height: 150);
      } else {
        return Image(image: AssetImage('assets/sun_cloudy.png'),width: 150,height: 150);
      }
    }
  }

  _getLocation() {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      _getAddressFromLatLng(position);
    }).catchError((e) {
      print(e);
    });
  }
  _getAddressFromLatLng(position) async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(position.latitude,position.longitude);
      Placemark place = p[0];
      print(place.subAdministrativeArea);
      setState(() {
        print(position.toString());
        location = position;
        address=place.subAdministrativeArea;
      });
    } catch (e) {
      print(e);
    }
  }


  dispose() {
    super.dispose();
  }
}
