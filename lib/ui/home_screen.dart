import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_with_me/bloc/weather_bloc.dart';
import 'package:weather_with_me/model/weather_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenStateful createState() => _HomeScreenStateful();
}

class _HomeScreenStateful extends State<HomeScreen> {
  Position location;
  String address;
  bool isDrawerOpen=false;

  @override
  Widget build(BuildContext context) {
    if (location != null) {
      weatherBloc.fetchWeatherData(
          location.latitude.toString(), location.longitude.toString());
    }
    return StreamBuilder(
      stream: weatherBloc.weather,
      // ignore: missing_return
      builder: (context, AsyncSnapshot<WeatherModel> snapshot) {
        if (snapshot.hasData) {
          return _buildHomeScreen(snapshot.data);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  _buildHomeScreen(WeatherModel data) {
    return Scaffold(

    );
  }

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  _getLocation() {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        print(position.toString());
        location = position;
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(location.latitude, location.longitude);

      Placemark place = p[0];

      setState(() {

      });
    } catch (e) {
      print(e);
    }
  }


  dispose() {
    super.dispose();
  }
}
