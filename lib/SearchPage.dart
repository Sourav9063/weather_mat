import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:weather_mat/Backend/weatherdata.dart';
import 'package:weather_widget/WeatherWidget.dart';

class SearchPage extends StatefulWidget {
  final currentWeatherData;
  final hourData;
  SearchPage({this.currentWeatherData, this.hourData});

  // SearchPage({this.conditions});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var searchedCity;

  dynamic searchedCityWeather;
  dynamic searchedCityDaily;
  int conditionNum;
  String city;
  String iconss;
  String condition;
  String descrip;
  String tmp;
  String tmpfeel;
  String searchedLat;
  String searchedLon;
  String formattedSunrise;
  String formattedSunset;
  String citySearchName;
  Widget animationss;
  WeatherData weatherData = WeatherData();

  double windspeed;
  int winddir;

  String hM;
  String hD;

  @override
  void initState() {
    super.initState();
    updateUI(widget.currentWeatherData);
    updateHourUI(widget.hourData);
    // print(widget.currentWeatherData);
  }

  String timeConvt(int time) {
    DateTime sunrise =
        DateTime.fromMillisecondsSinceEpoch(time * 1000, isUtc: false);

    // print(sunrise);

    return DateFormat.Hm().format(sunrise);
  }

  dynamic hourDatas;

  void updateHourUI(dynamic hourData) {
    setState(() {
      hourDatas = hourData;
    });
  }

  Card hourlyList(int hours) {
    // print(hourDatas);
    String iconssh;
    String time;
    var tmpd = hourDatas['hourly'][hours]['temp'];
    String tmp = tmpd.toString();

    setState(() {
      tmp = tmp.substring(0, 2);

      hM = hourDatas['hourly'][hours]['weather'][0]['main'];
      // print(hM);
      hD = hourDatas['hourly'][hours]['weather'][0]['description'];
      // print(hD);
      iconssh = hourDatas['hourly'][hours]['weather'][0]['icon'];

      time = timeConvt(hourDatas['hourly'][hours]['dt']);
    });

    return Card(
      child: ListTile(
        title: Text(hM),
        subtitle: Text('$hD\n$tmp°C'),
        isThreeLine: true,
        leading:
            Image.network('http://openweathermap.org/img/wn/$iconssh@2x.png'),
        trailing: Text(time),
      ),
    );
  }

  void updateUI(dynamic usableWData) {
    setState(() {
      // print(usableWData);
      conditionNum = usableWData['weather'][0]['id'];

      animationss = getWeatherIcon(conditionNum);
      iconss = usableWData['weather'][0]['icon'];

      var tmpd = usableWData['main']['temp'];
      tmp = tmpd.toString();
      tmp = tmp.substring(0, 2);
      var tmpfeeld = usableWData['main']['feels_like'];
      tmpfeel = tmpfeeld.toString();
      city = usableWData['name'];
      // city = city.toUpperCase();
      descrip = usableWData['weather'][0]['description'];
      condition = usableWData['weather'][0]['main'];
      formattedSunrise = timeConvt(usableWData['sys']['sunrise']);
      formattedSunset = timeConvt(usableWData['sys']['sunset']);

      windspeed = usableWData['wind']['speed'];
      winddir = usableWData['wind']['deg'];

      // print(formattedSunrise);
      // print(formattedSunset);
    });
  }

  Widget getWeatherIcon(int condition) {
    if (condition < 210) {
      return WeatherWidget(
        size: Size.infinite,
        weather: 'Thunder',
        thunderConfig: ThunderConfig(),
      );
    } else if (condition < 300) {
      return WeatherWidget(
          size: Size.infinite,
          weather: 'Thunder',
          thunderConfig: ThunderConfig());
    } else if (condition < 310) {
      return WeatherWidget(
          size: Size.infinite,
          weather: 'Rainy',
          rainConfig: RainConfig(
            rainNum: 20,
          ));
    } else if (condition < 400) {
      return WeatherWidget(
          size: Size.infinite,
          weather: 'Rainy',
          rainConfig: RainConfig(rainNum: 40));
    } else if (condition < 502) {
      return WeatherWidget(
          size: Size.infinite,
          weather: 'Rainy',
          rainConfig: RainConfig(rainNum: 11));
    } else if (condition < 600) {
      return WeatherWidget(
          size: Size.infinite,
          weather: 'Rainy',
          rainConfig: RainConfig(rainNum: 60));
    } else if (condition < 700) {
      return WeatherWidget(
          size: Size.infinite,
          weather: 'Snowy',
          snowConfig: SnowConfig(snowNum: 10));
    } else if (condition < 800) {
      if (condition == 741 ||
          condition == 701 ||
          condition == 711 ||
          condition == 781) {
        return WeatherWidget(
          weather: 'Sunny',
          size: Size.infinite,
          sunConfig: SunConfig(),
        );
      } else if (condition == 721) {
        return WeatherWidget(
            weather: 'Sunny', size: Size.infinite, sunConfig: SunConfig());
      } else {
        return WeatherWidget(
          size: Size.infinite,
          weather: 'Sunny',
          sunConfig: SunConfig(),
        );
      }
    } else if (condition == 800) {
      return WeatherWidget(
        size: Size.infinite,
        weather: 'Sunny',
        sunConfig: SunConfig(),
      );
    } else if (condition <= 804) {
      return WeatherWidget(
        size: Size.infinite,
        weather: 'Cloudy',
        cloudConfig: CloudConfig(),
      );
    } else {
      return WeatherWidget(
        size: Size.infinite,
        weather: 'Cloudy',
        cloudConfig: CloudConfig(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.currentWeatherData);

    return Container(
        child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.blue.shade900,
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    // flex: 6,

                    child: Container(
                      margin: EdgeInsets.fromLTRB(15, 15, 15, 0),

                      // padding: EdgeInsets.all(3),

                      color: Color(0xffE63946),

                      child: Center(
                        child: Text(
                          city,
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )),

          // Expanded(

          //   flex: 6,

          //   child: WeatherWidget(

          //     weather: "Thunder",

          //     size: Size.infinite,

          //     cloudConfig: CloudConfig(),

          //   ),

          // ),

          Expanded(
              flex: 6,
              child: Container(
                margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
                color: Color(0xff457B9D),
                child: Stack(
                  children: <Widget>[
                    Positioned(child: animationss),
                    Positioned(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '$tmp°C',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 50,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text('Feels Like: $tmpfeel°C'),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Sunrise: $formattedSunrise\n Sunset: $formattedSunset',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.end,

                              // crossAxisAlignment: CrossAxisAlignment.center,

                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Image.network(
                                          'http://openweathermap.org/img/wn/$iconss@2x.png')),
                                ),
                                Text(
                                  condition,
                                  style: TextStyle(fontSize: 17),
                                ),
                                Text(descrip),
                                Expanded(
                                  child: WindIcon(
                                    degree: winddir,
                                    size: 70,
                                    color: Colors.white,
                                  ),
                                ),
                                Text('$windspeed m/s$conditionNum'),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )),

          Expanded(
              flex: 4,
              child: ListView(
                padding: EdgeInsets.all(10),
                children: <Widget>[
                  hourlyList(0),
                  hourlyList(1),
                  hourlyList(2),
                  hourlyList(3),
                  hourlyList(4),
                  hourlyList(5),
                  hourlyList(6),
                  hourlyList(7),
                  hourlyList(8),
                  hourlyList(9),
                ],
              )),

          // weather[0].icon
        ],
      ),
    )));
  }
}
