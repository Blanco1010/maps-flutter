part of 'maps_bloc.dart';

@immutable
class MapsState {
  final bool mapReady;
  final bool drawRoute;
  final bool followUbication;
  final LatLng? centralUbication;

  // Polylines
  final Map<String, Polyline>? polylines;
  final Map<String, Marker> markers;

  MapsState({
    this.mapReady = false,
    this.drawRoute = false,
    this.followUbication = false,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
    this.centralUbication,
  })  : this.polylines = polylines ?? new Map(),
        this.markers = markers ?? new Map();

  MapsState copyWith({
    bool? mapReady,
    bool? drawRoute,
    bool? followUbication,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
    LatLng? centralUbication,
  }) =>
      MapsState(
        mapReady: mapReady ?? this.mapReady,
        drawRoute: drawRoute ?? this.drawRoute,
        followUbication: followUbication ?? this.followUbication,
        polylines: polylines ?? this.polylines,
        markers: markers ?? this.markers,
        centralUbication: centralUbication ?? this.centralUbication,
      );
}
