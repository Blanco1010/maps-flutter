part of 'maps_bloc.dart';

@immutable
abstract class MapsEvent {}

class OnMapReady extends MapsEvent {}

class OnLocationUpdate extends MapsEvent {
  final LatLng ubication;
  OnLocationUpdate(this.ubication);
}
