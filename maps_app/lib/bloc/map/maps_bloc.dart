import 'dart:convert';
import 'package:flutter/material.dart' show Colors, Offset;
import 'package:maps_app/helpers/helpers.dart';
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
    polylineId: PolylineId('my_route'),
    width: 3,
    color: Colors.transparent,
  );

  Polyline _myRouteDestination = new Polyline(
    polylineId: PolylineId('my_route_destination'),
    width: 3,
    color: Colors.black87,
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

  Stream<MapsState> mapEventToState(MapsEvent event) async* {
    if (event is OnMapReady) {
      yield state.copyWith(mapReady: true);
    }

    if (event is OnLocationUpdate) {
      yield* this._onChangeUbication(event);
    }

    if (event is OnChangeDraw) {
      yield* this._onChangeDraw(event);
    }

    if (event is OnFollowUbication) {
      yield* this._onFollowUbication(event);
    }

    if (event is OnMoveMap) {
      yield state.copyWith(centralUbication: event.centralMap);
    }

    if (event is OnCreateRouteInitialEnd) {
      yield* this._onCreateRouteInitialEnd(event);
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

  Stream<MapsState> _onCreateRouteInitialEnd(
      OnCreateRouteInitialEnd event) async* {
    this._myRouteDestination = this._myRouteDestination.copyWith(
          pointsParam: event.routeCoordinates,
        );

    final currentPolylines = state.polylines;
    currentPolylines?['my_route_destination'] = this._myRouteDestination;

    //Icons for ubications
    // final iconInitial = await getNetworkImageMarker();
    final iconInitial = await getMarkerInitialIcon(event.duration.toInt());

    // final iconDestination = await getAssetImageMarker();
    final iconDestination =
        await getMarkerDestinationIcon(event.nameDestination, event.distance);

    //Markers
    final markerInitial = new Marker(
      anchor: Offset(0.0, 1.0),
      markerId: MarkerId('initial'),
      position: event.routeCoordinates[0],
      icon: iconInitial,
      infoWindow: InfoWindow(
        title: 'Mi ubicación',
        snippet: 'Duración recorrido: ${(event.duration / 60).floor()} minutos',
        anchor: Offset(0.5, 0.0),
      ),
    );

    double km = event.distance / 1000;
    km = (km * 100).floor().toDouble();
    km = (km / 100);

    final markerEnd = new Marker(
      markerId: MarkerId('end'),
      position: event.routeCoordinates[event.routeCoordinates.length - 1],
      icon: iconDestination,
      infoWindow: InfoWindow(
        title: event.nameDestination,
        snippet: 'Distancia: $km Km',
      ),
      anchor: Offset(0.1, 1.0),
    );

    final newMarkers = {...state.markers};
    newMarkers['initial'] = markerInitial;
    newMarkers['end'] = markerEnd;

    Future.delayed(Duration(milliseconds: 300)).then((value) => {
          // _mapController!.showMarkerInfoWindow(MarkerId('initial')),
          // _mapController!.showMarkerInfoWindow(MarkerId('end')),
        });

    // get points for drawing
    yield state.copyWith(
      polylines: currentPolylines,
      markers: newMarkers,
    );
  }
}
