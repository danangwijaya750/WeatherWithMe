import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_with_me/model/weather_model.dart';
class ApiService{
  static const BASE_URL="https://api.openweathermap.org/data/2.5/onecall";
  static const APP_ID="b1e9e6c5fe162498b579958080d7b0af";

  Future getWeatherData(String lat,String lng)async{
    var endpoint="?lat="+lat+"&lon="+lng+"&exclude=minutely&units=metric&appid="+APP_ID;
    var url=BASE_URL+endpoint;
    print(url);
    final response = await http.get(url);
    print(response.body.toString());
    if(response.statusCode==200){
      var data = json.decode(response.body);
      return WeatherModel.fromJson(data);
    }else{
      throw Exception("error");
    }
  }
}