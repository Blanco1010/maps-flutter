import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'my_ubication_event.dart';
part 'my_ubication_state.dart';

class MyUbicationBloc extends Bloc<MyUbicationEvent, MyUbicationState> {
  MyUbicationBloc() : super(MyUbicationState());

  @override
  Stream<MyUbicationState> mapEventToState(MyUbicationEvent event) async* {
    // TODO: implement mapEventToState
  }
}
