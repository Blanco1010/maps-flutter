part of 'maps_bloc.dart';

@immutable
class MapsState {
  final bool mapReady;

  MapsState({this.mapReady = false});

  copyWith({bool? mapReady}) => MapsState(mapReady: mapReady ?? this.mapReady);
}
