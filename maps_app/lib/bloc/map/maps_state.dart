part of 'maps_bloc.dart';

@immutable
class MapsState {
  final bool mapReady;
  final bool drawRoute;
  final bool followUbication;
  final LatLng? centralUbication;

  // Polylines
  final Map<String, Polyline>? polylines;

  MapsState({
    this.mapReady = false,
    this.drawRoute = false,
    this.followUbication = false,
    Map<String, Polyline>? polylines,
    this.centralUbication,
  }) : this.polylines = polylines ?? new Map();

  MapsState copyWith({
    bool? mapReady,
    bool? drawRoute,
    bool? followUbication,
    Map<String, Polyline>? polylines,
    LatLng? centralUbication,
  }) =>
      MapsState(
        mapReady: mapReady ?? this.mapReady,
        drawRoute: drawRoute ?? this.drawRoute,
        followUbication: followUbication ?? this.followUbication,
        polylines: polylines ?? this.polylines,
        centralUbication: centralUbication ?? this.centralUbication,
      );
}
