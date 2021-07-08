import 'dart:convert';
import 'package:flutter/material.dart' show Colors;
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/themes/uber_map_theme.dart';

part 'maps_event.dart';
part 'maps_state.dart';

class MapsBloc extends Bloc<MapsEvent, MapsState> {
  MapsBloc() : super(MapsState());

  //Map Controller
  GoogleMapController? _mapController;

  //Polylines
  Polyline _myRoute = new Polyline(
      polylineId: PolylineId('my_route'), width: 3, color: Colors.transparent);

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

  Stream<MapsState> mapEventToState(MapsEvent event) async* {
    if (event is OnMapReady) {
      yield state.copyWith(mapReady: true);
    }

    if (event is OnLocationUpdate) {
      yield* this._onChangeUbication(event);
    }

    if (event is OnChangeDraw) {
      yield* _onChangeDraw(event);
    }

    if (event is OnFollowUbication) {
      yield* _onFollowUbication(event);
    }

    if (event is OnMoveMap) {
      print('object');
      print(event.centralMap);
      yield state.copyWith(centralUbication: event.centralMap);
    }
  }

  Stream<MapsState> _onChangeUbication(OnLocationUpdate event) async* {
    if (state.followUbication) {
      this.moveCamera(event.ubication);
    }

    final List<LatLng> points = [...this._myRoute.points, event.ubication];
    this._myRoute = this._myRoute.copyWith(pointsParam: points);

    final currentPolylines = state.polylines;
    currentPolylines?['mi_route'] = this._myRoute;

    yield state.copyWith(polylines: currentPolylines);
  }

  Stream<MapsState> _onChangeDraw(OnChangeDraw event) async* {
    if (state.drawRoute) {
      this._myRoute = this._myRoute.copyWith(colorParam: Colors.black);
    } else {
      this._myRoute = this._myRoute.copyWith(colorParam: Colors.transparent);
    }

    final currentPolylines = state.polylines;
    currentPolylines?['mi_route'] = this._myRoute;

    yield state.copyWith(drawRoute: !state.drawRoute);
  }

  Stream<MapsState> _onFollowUbication(OnFollowUbication event) async* {
    if (!state.followUbication) {
      this.moveCamera(this._myRoute.points[this._myRoute.points.length - 1]);
    }

    yield state.copyWith(followUbication: !state.followUbication);
  }
}
