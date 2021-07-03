import 'package:flutter/material.dart';
import 'package:maps_app/pages/acces_gps_page.dart';
import 'package:maps_app/pages/loading_page.dart';
import 'package:maps_app/pages/map_gps_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: LoagindPage(),
      routes: {
        'map': (_) => MapGpsPage(),
        'loading': (_) => LoagindPage(),
        'acces_gps': (_) => AccesGpsPage(),
      },
    );
  }
}
