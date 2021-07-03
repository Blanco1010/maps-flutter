import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:maps_app/helpers/helpers.dart';
import 'package:maps_app/pages/acces_gps_page.dart';
import 'package:maps_app/pages/map_gps_page.dart';

class LoagindPage extends StatefulWidget {
  @override
  _LoagindPageState createState() => _LoagindPageState();
}

class _LoagindPageState extends State<LoagindPage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print('======>  $state ');

    if (state == AppLifecycleState.resumed) {
      if (await Geolocator.isLocationServiceEnabled()) {
        Navigator.pushReplacement(
            context, navigateMapFadein(context, MapGpsPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: this.checkGpsLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Text(snapshot.data),
            );
          } else {
            return Center(child: CircularProgressIndicator(strokeWidth: 2));
          }
        },
      ),
    );
  }

  Future checkGpsLocation(BuildContext context) async {
    //Get location permission status
    final gpsPermite = await Permission.location.isGranted;
    print('GPS Permissions: $gpsPermite');

    //If the gps is activated get true
    final gpsActive = await Geolocator.isLocationServiceEnabled();
    print('GPS is activated: $gpsActive');

    if (gpsPermite && gpsActive) {
      Navigator.pushReplacement(
          context, navigateMapFadein(context, MapGpsPage()));
      return '';
    } else if (!gpsPermite) {
      Navigator.pushReplacement(
          context, navigateMapFadein(context, AccesGpsPage()));
      return 'requires GPS permission';
    } else if (gpsActive) {
      return 'activate GPS';
    }

    // await Future.delayed(Duration(milliseconds: 1000), () {
    //   Navigator.pushReplacement(
    //       context, navigateMapFadein(context, MapGpsPage()));
    // });

    await Future.delayed(Duration(milliseconds: 1000));
  }
}
