part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class OnActiveMarkerManual extends SearchEvent {}

class OnDeactivateMarkerManual extends SearchEvent {}
