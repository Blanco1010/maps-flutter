part of 'maps_bloc.dart';

@immutable
class MapsState {
  final bool mapReady;
  late final bool drawRoute;

  // Polylines
  final Map<String, Polyline>? polylines;

  MapsState({
    this.mapReady = false,
    this.drawRoute = true,
    Map<String, Polyline>? polylines,
  }) : this.polylines = polylines ?? new Map();

  copyWith({
    bool? mapReady,
    bool? drawRoute,
    Map<String, Polyline>? polylines,
  }) =>
      MapsState(
        mapReady: mapReady ?? this.mapReady,
        polylines: polylines ?? this.polylines,
        drawRoute: drawRoute ?? this.drawRoute,
      );
}
