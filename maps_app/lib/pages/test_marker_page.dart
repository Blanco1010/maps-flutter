import 'package:flutter/material.dart';
import 'package:maps_app/custom_markers/custom_market.dart';

class TestMarkerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          height: 150,
          color: Colors.red,
          child: CustomPaint(
              // painter: MarkerDestinationPainter(
              //     'Mi casa por algún lado del mundo, esta aquí,asdd asdd ddd',
              //     351202),
              painter: MarkerInitialPainter(51)),
        ),
      ),
    );
  }
}
