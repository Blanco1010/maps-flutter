part of 'maps_bloc.dart';

@immutable
abstract class MapsEvent {}

class OnMapReady extends MapsEvent {}

class OnChangeDraw extends MapsEvent {}

class OnFollowUbication extends MapsEvent {}

class OnCreateRouteInitialEnd extends MapsEvent {
  final List<LatLng> routeCoordinates;
  final double distance;
  final double duration;
  final String nameDestination;

  OnCreateRouteInitialEnd(
    this.routeCoordinates,
    this.distance,
    this.duration,
    this.nameDestination,
  );
}

class OnMoveMap extends MapsEvent {
  final LatLng centralMap;
  OnMoveMap(this.centralMap);
}

class OnLocationUpdate extends MapsEvent {
  final LatLng ubication;
  OnLocationUpdate(this.ubication);
}
