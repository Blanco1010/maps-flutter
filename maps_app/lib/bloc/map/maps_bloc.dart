import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/themes/uber_map_theme.dart';

part 'maps_event.dart';
part 'maps_state.dart';

class MapsBloc extends Bloc<MapsEvent, MapsState> {
  MapsBloc() : super(new MapsState());

  //Map Controller
  GoogleMapController? _mapController;

  //Polylines
  Polyline _myRoute = new Polyline(
    polylineId: PolylineId('my_route'),
    width: 3,
  );

  void initMap(GoogleMapController controller) {
    if (!state.mapReady) {
      this._mapController = controller;
      //Change the map stylethis.
      this._mapController?.setMapStyle(jsonEncode(uberMapTheme));

      add(OnMapReady());
    }
  }

  void moveCamera(LatLng destination) {
    final cameraUpdate = CameraUpdate.newLatLng(destination);
    this._mapController?.animateCamera(cameraUpdate);
  }

  @override
  Stream<MapsState> mapEventToState(MapsEvent event) async* {
    if (event is OnMapReady) {
      await state.copyWith(mapReady: true);
    }

    if (event is OnLocationUpdate) {
      List<LatLng> points = [...this._myRoute.points, event.ubication];
      this._myRoute = this._myRoute.copyWith(pointsParam: points);

      final currentPolylines = state.polylines;
      currentPolylines?['mi_route'] = this._myRoute;

      await state.copyWith(polylines: currentPolylines);
    }
  }
}
