part of 'search_bloc.dart';

@immutable
class SearchState {
  final bool selectManual;
  final List<SearchResult>? history;

  SearchState({
    this.selectManual = false,
    List<SearchResult>? history,
  }) : this.history = (history == null) ? [] : history;

  SearchState copyWith({bool? selectManual, List<SearchResult>? history}) =>
      SearchState(
        selectManual: selectManual ?? this.selectManual,
        history: history ?? this.history,
      );
}
