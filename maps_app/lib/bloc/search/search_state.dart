part of 'search_bloc.dart';

@immutable
class SearchState {
  final bool selectManual;

  SearchState({this.selectManual = false});

  SearchState copyWith({bool? selectManual}) => SearchState(
        selectManual: selectManual ?? this.selectManual,
      );
}
