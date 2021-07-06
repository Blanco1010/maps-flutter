import 'dart:async';
import 'dart:developer';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'maps_event.dart';
part 'maps_state.dart';

class MapsBloc extends Bloc<MapsEvent, MapsState> {
  MapsBloc() : super(new MapsState());

  GoogleMapController? _myController;

  void initMap(GoogleMapController controller) {
    if (!state.mapReady) {
      this._myController = controller;
      //TODO: Change the map style
      add(OnMapReady());
    }
  }

  @override
  Stream<MapsState> mapEventToState(MapsEvent event) async* {
    if (event is OnMapReady) {
      log('READY MAP');
      await state.copyWith(mapReady: true);
    }
  }
}
