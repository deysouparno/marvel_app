import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class CharacterPageStateCubit extends Cubit<SearchState> {
  CharacterPageStateCubit() : super(NotSearching());

  void emitSearching() => emit(Searching());
  void emitNotSearching() => emit(NotSearching());
  void emitDoneSearching() => emit(DoneSearching());
  void emitTyping() => emit(Typing());
  void emitRefreshing() => emit(Refreshing());
}

class ComicPageStateCubit extends Cubit<SearchState> {
  ComicPageStateCubit() : super(NotSearching());

  void emitSearching() => emit(Searching());
  void emitNotSearching() => emit(NotSearching());
  void emitDoneSearching() => emit(DoneSearching());
  void emitTyping() => emit(Typing());
  void emitRefreshing() => emit(Refreshing());
}

class CharacterDetailsCubit extends Cubit<SearchState> {
  CharacterDetailsCubit() : super(NotSearching());

  void emitLoading() => emit(Refreshing());

  void emitLoaded() => emit(NotSearching());
}
