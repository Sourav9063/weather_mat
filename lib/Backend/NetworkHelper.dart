import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  String urll;
  NetworkHelper({this.urll});

  Future getRawWeatherData() async {
    http.Response response = await http.get(urll);

    // print(response.statusCode);
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    } 
  }
}

//get the url and return converted json to data
