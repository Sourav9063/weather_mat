import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';

import 'package:weather_mat/Backend/weatherdata.dart';
import 'package:weather_mat/Frontend/SearchPage.dart';
// import 'package:weather_mat/SearchPage.dart';

import 'package:weather_widget/WeatherWidget.dart';

class CurrentWeather extends StatefulWidget {
  final currentWeatherData;
  final hourData;
  CurrentWeather({this.currentWeatherData, this.hourData});

  @override
  _CurrentWeatherState createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  var searchedCity = 'Search';
  ScrollController controller = ScrollController();
  bool closeContainer = false;

  List<Card> listCard = [];
  // dynamic searchedCityWeather;
  // dynamic searchedCityDaily;
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
    getList(48);
    controller.addListener(() {
      setState(() {
        closeContainer = controller.offset > 50;
      });
    });
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

  // Widget getWeatherIcon(int condition) {
  //   if (condition < 210) {
  //     return WeatherWidget(
  //       size: Size.infinite,
  //       weather: 'Thunder',
  //       thunderConfig: ThunderConfig(
  //         thunderColor: Colors.white,
  //         thunderWidth: 4,
  //       ),
  //     );
  //   } else if (condition < 300) {
  //     return WeatherWidget(
  //         size: Size.infinite,
  //         weather: 'Thunder',
  //         thunderConfig: ThunderConfig(
  //           thunderColor: Colors.white,
  //         ));
  //   } else if (condition < 310) {
  //     return WeatherWidget(
  //       size: Size.infinite,
  //       weather: 'Cloudy',
  //       cloudConfig: CloudConfig(
  //           bottomColor: Colors.blueAccent, topColor: Colors.blueGrey.shade700),
  //     );
  //   } else if (condition < 400) {
  //     return WeatherWidget(
  //         size: Size.infinite,
  //         weather: 'Rainy',
  //         rainConfig: RainConfig(rainNum: 80, rainLength: 7));
  //   } else if (condition < 502) {
  //     return WeatherWidget(
  //       size: Size.infinite,
  //       weather: 'Cloudy',
  //       cloudConfig: CloudConfig(
  //           bottomColor: Colors.blueAccent, topColor: Colors.blueGrey.shade700),
  //     );
  //   } else if (condition < 600) {
  //     return WeatherWidget(
  //         size: Size.infinite,
  //         weather: 'Rainy',
  //         rainConfig: RainConfig(rainNum: 100));
  //   } else if (condition < 700) {
  //     return WeatherWidget(
  //         size: Size.infinite,
  //         weather: 'Snowy',
  //         snowConfig: SnowConfig(snowNum: 10));
  //   } else if (condition < 800) {
  //     if (condition == 741 ||
  //         condition == 701 ||
  //         condition == 711 ||
  //         condition == 781) {
  //       return WeatherWidget(
  //         weather: 'Sunny',
  //         size: Size.infinite,
  //         sunConfig: SunConfig(
  //             sunBlurStyle: BlurStyle.normal,
  //             sunInColor: Colors.white,
  //             sunOutColor: Colors.grey,
  //             bottomColor: Colors.grey,
  //             topColor: Colors.blueGrey),
  //       );
  //     } else if (condition == 721) {
  //       return WeatherWidget(
  //           weather: 'Sunny',
  //           size: Size.infinite,
  //           sunConfig:
  //               SunConfig(bottomColor: Colors.grey, topColor: Colors.blueGrey));
  //     } else {
  //       return WeatherWidget(
  //         size: Size.infinite,
  //         weather: 'Sunny',
  //         sunConfig: SunConfig(),
  //       );
  //     }
  //   } else if (condition == 800) {
  //     return WeatherWidget(
  //       size: Size.infinite,
  //       weather: 'Sunny',
  //       sunConfig: SunConfig(),
  //     );
  //   } else if (condition <= 804) {
  //     return WeatherWidget(
  //       size: Size.infinite,
  //       weather: 'Cloudy',
  //       cloudConfig: CloudConfig(bottomColor: Colors.blueAccent),
  //     );
  //   } else {
  //     return WeatherWidget(
  //       size: Size.infinite,
  //       weather: 'Cloudy',
  //       cloudConfig: CloudConfig(topColor: Colors.black26),
  //     );
  //   }
  // }

  Widget getWeatherIcon(int condition) {
    if (condition < 210) {
      return WeatherWidget(
        size: Size.infinite,
        weather: 'Thunder',
        thunderConfig: ThunderConfig(
          thunderColor: Colors.white,
          thunderWidth: 4,
        ),
      );
    } else if (condition < 300) {
      return WeatherWidget(
          size: Size.infinite,
          weather: 'Thunder',
          thunderConfig: ThunderConfig(
            thunderColor: Colors.white,
          ));
    } else if (condition < 310) {
      return WeatherWidget(
          size: Size.infinite,
          weather: 'Rainy',
          rainConfig: RainConfig(
            rainNum: 20,
            rainLength: 7,
          ));
    } else if (condition < 400) {
      return WeatherWidget(
          size: Size.infinite,
          weather: 'Rainy',
          rainConfig: RainConfig(rainNum: 80, rainLength: 7));
    } else if (condition < 502) {
      return WeatherWidget(
          size: Size.infinite,
          weather: 'Rainy',
          rainConfig: RainConfig(rainNum: 30));
    } else if (condition < 600) {
      return WeatherWidget(
          size: Size.infinite,
          weather: 'Rainy',
          rainConfig: RainConfig(rainNum: 100));
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
          sunConfig: SunConfig(
              sunBlurStyle: BlurStyle.normal,
              sunInColor: Colors.white,
              sunOutColor: Colors.grey,
              bottomColor: Colors.grey,
              topColor: Colors.blueGrey),
        );
      } else if (condition == 721) {
        return WeatherWidget(
            weather: 'Sunny',
            size: Size.infinite,
            sunConfig:
                SunConfig(bottomColor: Colors.grey, topColor: Colors.blueGrey));
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

  void getList(int n) {
    for (int i = 0; i < n; i++) {
      listCard.add(hourlyList(i));
    }
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
      color: Colors.white70,
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

  // void updateSearchedLoc(dynamic usableWData) {
  //   searchedLat = usableWData['coord']['lat'].toString();
  //   searchedLon = usableWData['coord']['lon'].toString();
  // }

  void updateUI(var usableWData) {
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

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    // setState(() {
    //   closeContainer = controller.offset > 50;
    // });
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xff77ABBD),
        body: Column(
          children: <Widget>[
            Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        height: screen.height * .07,
                        // width: screen.width * .95,
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                                child: GestureDetector(
                              onTap: () async {
                                updateUI(await weatherData.currentWeather());

                                updateHourUI(
                                    await weatherData.allWeatherData());
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    // shape: BoxShape.circle,
                                    borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(4)),
                                    color: Colors.lightGreen),
                                child: Center(
                                  child: Icon(
                                    Icons.location_on,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )),
                            Expanded(
                              flex: 4,
                              child: GestureDetector(
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return SearchScreen();
                                      },
                                    ),
                                  );

                                  // setState(() {
                                  //   searchedCity = searchedCity;
                                  // });
                                  // print(searchedCity.toString());

                                  // searchedCityWeather =
                                  //     await weatherData.cityWeather(searchedCity);
                                  // updateSearchedLoc(searchedCityWeather);
                                  // searchedCityDaily =
                                  //     await weatherData.allSearchWeatherData(
                                  //         searchedLat, searchedLon);
                                  // // print(searchedCityWeather);
                                  // // print(searchedCityDaily);
                                },
                                child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Text(
                                        'Search',
                                        style: TextStyle(
                                          fontSize: 25,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: GestureDetector(
                                // focusColor: Colors.blue,

                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return SearchScreen();
                                      },
                                    ),
                                  );
                                  // print(searchedCityWeather);
                                  // print(searchedCityDaily);
                                  // if (searchedCity != 'Search' &&
                                  //     searchedCity != null &&
                                  //     searchedCityDaily != null &&
                                  //     searchedCityWeather != null) {
                                  //   Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) {
                                  //         return SearchPage(
                                  //           hourData: searchedCityDaily,
                                  //           currentWeatherData: searchedCityWeather,
                                  //         );
                                  //       },
                                  //     ),
                                  //   );
                                  // }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.horizontal(
                                        right: Radius.circular(4)),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.white,
                                        Color(0xffE63946),
                                        Color(0xffE63946),
                                      ],
                                    ),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.search,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            )
                          ],
                        )),
                    Expanded(
                      // flex: 6,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(15, 7, 15, 0),

                        // padding: EdgeInsets.all(3),
                        color: Color(0xffE63946),
                        child: Center(
                          child: Text(
                            city,
                            style: TextStyle(
                              fontSize: 25,
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

            AnimatedContainer(
              duration: Duration(milliseconds: 600),
              height: closeContainer ? 0 : screen.height * .50,
              // width: closeContainer ? 0 : screen.width,
              curve: Curves.fastOutSlowIn,
              // alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.fromLTRB(15, 0, 15, 7),
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
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            '$tmp°C',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 50,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text('Feels Like: $tmpfeel°C'),
                                      ),
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
                                  flex: 2,
                                  child: Container(
                                      // margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Image.network(
                                          'http://openweathermap.org/img/wn/$iconss@2x.png')),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      condition,
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(child: Text(descrip)),
                                Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: WindIcon(
                                      degree: winddir,
                                      size: 70,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text('$windspeed m/s'),
                                  ),
                                ),

                                // Expanded(
                                //   child: Container(
                                //       margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                //       child: Image.network(
                                //           'http://openweathermap.org/img/wn/$iconss@2x.png')),
                                // ),
                                // Text(
                                //   condition,
                                //   style: TextStyle(fontSize: 17),
                                // ),
                                // Text(descrip),
                                // Expanded(
                                //   child: WindIcon(
                                //     degree: winddir,
                                //     size: 70,
                                //     color: Colors.white,
                                //   ),
                                // ),
                                // Text('$windspeed m/s$conditionNum'),
                                // SizedBox(
                                //   height: 10,
                                // )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: ListView(
                physics: BouncingScrollPhysics(),
                controller: controller,
                padding: EdgeInsets.all(10),
                children: listCard,
              ),
            ),
            // weather[0].icon
          ],
        ),
      ),
    );
  }
}

//  Row(
//                     children: <Widget>[
//                       Expanded(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: <Widget>[
//                             Expanded(
//                               flex: 2,
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: <Widget>[
//                                   Text(
//                                     '$tmp°C',
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 50,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   Text('Feels Like: $tmpfeel°C'),
//                                 ],
//                               ),
//                             ),
//                             Expanded(
//                               flex: 1,
//                               child: Text(
//                                 'Sunrise: $formattedSunrise\n Sunset: $formattedSunset',
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 15),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                         child: Column(
//                           // mainAxisAlignment: MainAxisAlignment.end,
//                           // crossAxisAlignment: CrossAxisAlignment.center,
//                           children: <Widget>[
//                             Expanded(
//                               child: Container(
//                                   margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                                   child: Image.network(
//                                       'http://openweathermap.org/img/wn/$iconss@2x.png')),
//                             ),
//                             Text(
//                               condition,
//                               style: TextStyle(fontSize: 17),
//                             ),
//                             Text(descrip),
//                             Expanded(
//                               child: WindIcon(
//                                 degree: winddir,
//                                 size: 70,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             Text('$windspeed m/s'),
//                             SizedBox(
//                               height: 10,
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),

// child: TextField(
//   onSubmitted: (value) {
//     citySearchName = value;
//     setState(() async {
//       updateUI(await weatherData
//           .cityWeather(citySearchName));

//       updateHourUI(
//           await weatherData.allSearchWeatherData(
//               searchedLat, searchedLon));
//     });
//   },
//   onChanged: (value) {
//     citySearchName = value;
//   },
//   style: TextStyle(color: Colors.black),
//   decoration: InputDecoration(
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(8),
//       borderSide: BorderSide.none,
//     ),
//     hintText: city,
//     filled: true,
//     fillColor: Colors.white,
//     hintStyle: TextStyle(
//         color: Colors.grey,
//         fontSize: 18,
//         fontWeight: FontWeight.bold),
//   ),
// ),
