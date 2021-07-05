part of 'my_ubication_bloc.dart';

@immutable
class MyUbicationState {
  final bool following;
  final bool existUbication;
  final LatLng? ubication;

  MyUbicationState({
    this.following = true,
    this.existUbication = false,
    this.ubication,
  });

  MyUbicationState copyWith({
    bool? following,
    bool? existUbication,
    LatLng? ubication,
  }) =>
      new MyUbicationState(
        following: following ?? this.following,
        existUbication: existUbication ?? this.existUbication,
        ubication: ubication ?? this.ubication,
      );
}
