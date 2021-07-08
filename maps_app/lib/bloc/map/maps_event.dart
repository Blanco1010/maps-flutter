part of 'maps_bloc.dart';

@immutable
abstract class MapsEvent {}

class OnMapReady extends MapsEvent {}

class OnChangeDraw extends MapsEvent {}

class OnFollowUbication extends MapsEvent {}

class OnMoveMap extends MapsEvent {
  final LatLng centralMap;

  OnMoveMap(this.centralMap);
}

class OnLocationUpdate extends MapsEvent {
  final LatLng ubication;
  OnLocationUpdate(this.ubication);
}
