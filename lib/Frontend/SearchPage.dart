import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:weather_mat/Backend/weatherdata.dart';

import 'SearchedWeather.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  dynamic data;
  dynamic dailyData;
  bool isVisible = true;
  String lat;

  String lon;

  String citySearchedName = 'Enter City Name';

  WeatherData weatherData = WeatherData();
  void getFinaldata() async {
    var finaldata = await weatherData.cityWeather(citySearchedName);

    lat = finaldata['coord']['lat'].toString();
    lon = finaldata['coord']['lon'].toString();

    var hourdata = await weatherData.allSearchWeatherData(lat, lon);
    // print(finaldata);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SearchPage(
        currentWeatherData: finaldata,
        hourData: hourdata,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff14213d),
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Hero(
                tag: 'world',
                child: FlareActor(
                  'assets/WorldSpin.flr',
                  animation: 'roll',
                  alignment: Alignment.topCenter,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  onSubmitted: (value) async {
                    setState(() {
                      isVisible = false;
                    });

                    // dailyData = await getDailyData(citySearchedName);
                    // Navigator.pop(context, citySearchedName);
                    getFinaldata();
                  },
                  onChanged: (value) {
                    setState(() {
                      isVisible = true;
                    });

                    citySearchedName = value;
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    hintText: citySearchedName,
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Visibility(
                visible: isVisible,
                child: RawMaterialButton(
                  splashColor: Colors.pinkAccent.shade400,
                  focusColor: Colors.pinkAccent.shade200,
                  // fillColor: Colors.green,
                  // hoverColor:Colors.green ,
                  highlightColor: Colors.pinkAccent.shade200,
                  elevation: 10,

                  onPressed: () {
                    setState(() {
                      isVisible = false;
                    });

                    getFinaldata();
                  },
                  child: Container(
                    child: Icon(
                      Icons.search,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
