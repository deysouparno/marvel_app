import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(NotSearching());

  void emitSearching() => emit(Searching());
  void emitNotSearching() => emit(NotSearching());
  void emitDoneSearching() => emit(DoneSearching());
  void emitTyping() => emit(Typing());
  void emitRefreshing() => emit(Refreshing());
}
