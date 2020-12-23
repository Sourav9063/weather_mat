import 'package:flutter/material.dart';
import 'package:weather_mat/Backend/weatherdata.dart';
import 'package:weather_mat/Frontend/CurrentWeather.dart';
import 'Backend/location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xffA8DADC),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    getFinaldata();
  }

  Location location = Location();
  WeatherData weatherData = WeatherData();
  void getFinaldata() async {
    var finaldata = await weatherData.currentWeather();
    var hourdata = await weatherData.allWeatherData();
    // print(finaldata);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return CurrentWeather(
        currentWeatherData: finaldata,
        hourData: hourdata,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    // final Size screenSize = MediaQuery.of(context).size;

    // String iconss = finaldata['weather'][0]['icon'];
    // getFinaldata();
    return Scaffold(
      backgroundColor: Color(0xff1b4332),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(100.0),
              child: SpinKitDoubleBounce(
                color: Colors.white,
                size: 150,
              ),
            ),
            RaisedButton(
              onPressed: () {
                getFinaldata();
              },
              padding: EdgeInsets.all(10),
              color: Color(0xff457B9D),
              child: Text(
                'Get Weather',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            )
          ],
        ),
      ),
    );
  }
}
