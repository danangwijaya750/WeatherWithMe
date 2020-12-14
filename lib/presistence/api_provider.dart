import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_with_me/model/weather_model.dart';
class ApiService{
  static const BASE_URL="https://api.openweathermap.org/data/2.5/onecall";
  static const APP_ID="0da68c0d22745c634fbbd63d7137a097";

  Future getWeatherData(String lat,String lng)async{
    var endpoint="?lat="+lat+"&lon="+lng+"&exclude=minutely&appid="+APP_ID;
    var url=BASE_URL+endpoint;
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