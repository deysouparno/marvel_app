part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class NotSearching extends SearchState {}

class Searching extends SearchState {}

class DoneSearching extends SearchState {}

class Typing extends SearchState {}

class Refreshing extends SearchState {}
