import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

part 'my_ubication_event.dart';
part 'my_ubication_state.dart';

class MyUbicationBloc extends Bloc<MyUbicationEvent, MyUbicationState> {
  MyUbicationBloc() : super(MyUbicationState());

  StreamSubscription<Position>? _positionSubscription;

  void initialFollow() {
    // final locationOptions = LocationOptions(
    //   accuracy: LocationAccuracy.high,
    //   distanceFilter: 10,
    // );

    this._positionSubscription = Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high,
      distanceFilter: 10,
    ).listen((Position position) {
      print(position);
      final newUbication = LatLng(position.latitude, position.longitude);
      //emit the event OnChangeUbication
      add(OnChangeUbication(newUbication));
    });
  }

  void cancelFollow() {
    this._positionSubscription?.cancel();
  }

  @override
  Stream<MyUbicationState> mapEventToState(MyUbicationEvent event) async* {
    // print(event);
    if (event is OnChangeUbication) {
      yield state.copyWith(existUbication: true, ubication: event.ubication);
    }
  }
}
