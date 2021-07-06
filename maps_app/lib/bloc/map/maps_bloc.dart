import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/themes/uber_map_theme.dart';

part 'maps_event.dart';
part 'maps_state.dart';

class MapsBloc extends Bloc<MapsEvent, MapsState> {
  MapsBloc() : super(new MapsState());

  GoogleMapController? _mapController;

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
  }
}
