import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String citySearchedName;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: FlareActor(
                'assets/WorldSpin.flr',
                animation: 'roll',
                alignment: Alignment.topCenter,
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onSubmitted: (value) {
                    Navigator.pop(context, citySearchedName);
                  },
                  onChanged: (value) {
                    citySearchedName = value;
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Enter City Name',
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
              child: Container(
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context, citySearchedName);
                    },
                    child: Icon(
                      Icons.search,
                      size: 45,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
