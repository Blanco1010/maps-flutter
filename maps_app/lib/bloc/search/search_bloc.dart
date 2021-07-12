import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:maps_app/models/search_result.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is OnActiveMarkerManual) {
      yield state.copyWith(selectManual: true);
    }

    if (event is OnDeactivateMarkerManual) {
      yield state.copyWith(selectManual: false);
    }

    if (event is OnAddHistory) {
      final exist = state.history!
          .where((result) =>
              result.nameDestination == event.result.nameDestination)
          .length;

      if (exist == 0) {
        final newHistory = [...state.history!, event.result];
        yield state.copyWith(history: newHistory);
      }
    }
  }
}
