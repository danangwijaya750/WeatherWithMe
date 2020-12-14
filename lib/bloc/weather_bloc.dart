import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weather_with_me/model/weather_model.dart';
import 'package:weather_with_me/presistence/weather_repository.dart';

class WeatherBloc{
  WeatherRepository _repository = WeatherRepository();
  final _weatherFetcher = PublishSubject<WeatherModel>();
  Observable<WeatherModel> get weather => _weatherFetcher.stream;

  fetchWeatherData(lat,lng) async{
    var data= await _repository.getWeather(lat,lng);
    _weatherFetcher.sink.add(data);
  }
  fetchData(position) async{

  }

  dispose(){
    _weatherFetcher.close();
  }

}
final weatherBloc=WeatherBloc();