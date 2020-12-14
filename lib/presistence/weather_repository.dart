import 'package:weather_with_me/presistence/api_provider.dart';

class WeatherRepository{
  ApiService service=ApiService();
  Future getWeather(String lat, String lng) => service.getWeatherData(lat, lng);
}