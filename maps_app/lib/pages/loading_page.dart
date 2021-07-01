import 'package:flutter/material.dart';
import 'package:maps_app/helpers/helpers.dart';
import 'package:maps_app/pages/map_gps_page.dart';

class LoagindPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: this.checkGpsLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 8,
            ),
          );
        },
      ),
    );
  }

  Future checkGpsLocation(BuildContext context) async {
    //TODO: Permisse GPS
    //TODO: Gps is active

    await Future.delayed(Duration(milliseconds: 1000), () {
      Navigator.pushReplacement(
          context, navigateMapFadein(context, MapGpsPage()));
    });
  }
}
