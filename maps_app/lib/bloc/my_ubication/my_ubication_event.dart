part of 'my_ubication_bloc.dart';

@immutable
abstract class MyUbicationEvent {}

class OnChangeUbication extends MyUbicationEvent {
  final LatLng ubication;
  OnChangeUbication(this.ubication);
}
