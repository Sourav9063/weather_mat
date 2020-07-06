
import 'package:weather_mat/Backend/NetworkHelper.dart';
import 'package:weather_mat/Backend/location.dart';


const apikey =
    '289d47b58801684b9ce00dc9cdb10e8b'; //289d47b58801684b9ce00dc9cdb10e8b
const openWeather = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherData {
  Future<dynamic> cityWeather(String citySearchName) async {
    NetworkHelper networkHelper = NetworkHelper(
        urll: '$openWeather?q=$citySearchName&appid=$apikey&units=metric');

    return await networkHelper.getRawWeatherData();
  }

  Future<dynamic> currentWeather() async {
    Location location = Location();
    await location.getlocation();

    NetworkHelper networkHelper = NetworkHelper(
        urll:
            '$openWeather?lat=${location.getLat()}&lon=${location.getlon()}&appid=$apikey&units=metric');

    var data = await networkHelper.getRawWeatherData();
    return data;
  }

  Future<dynamic> allWeatherData() async {
    Location location = Location();
    await location.getlocation();

    NetworkHelper networkHelper = NetworkHelper(
        urll:
            'https://api.openweathermap.org/data/2.5/onecall?lat=${location.getLat()}&lon=${location.getlon()}&%20exclude=minutely&appid=289d47b58801684b9ce00dc9cdb10e8b&units=metric');

    // https://api.openweathermap.org/data/2.5/onecall?lat=90&lon=80&%20exclude=minutely&appid=289d47b58801684b9ce00dc9cdb10e8b&units=metric

    var data = await networkHelper.getRawWeatherData();
    return data;
  }

  Future<dynamic> allSearchWeatherData(String lat, String lon) async {
    // Location location = Location();
    // await location.getlocation();

    NetworkHelper networkHelper = NetworkHelper(
        urll:
            'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&%20exclude=minutely&appid=289d47b58801684b9ce00dc9cdb10e8b&units=metric');

    // https://api.openweathermap.org/data/2.5/onecall?lat=90&lon=80&%20exclude=minutely&appid=289d47b58801684b9ce00dc9cdb10e8b&units=metric

    var data = await networkHelper.getRawWeatherData();
    return data;
  }


}
