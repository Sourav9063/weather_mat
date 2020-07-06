import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  double _lat;
  double _lon;
  Future<void> getlocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

      _lat = position.latitude;
      _lon = position.longitude;

      // print(_lat);
      // print(_lon);
    } catch (e) {
      _lat = 0;
      _lon = 0;
      AlertDialog(
        backgroundColor: Colors.red,
        title: Text(
          'Cannot get your location',
          style: TextStyle(fontSize: 22, color: Colors.black),
        ),
      );
    }
  }

  double getLat() {
    return _lat;
  }

  double getlon() {
    return _lon;
  }
}
