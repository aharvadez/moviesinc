part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

final class SearchEventQueryChanged extends SearchEvent {
  final String query;

  SearchEventQueryChanged({required this.query});
}

final class SearchEventLoadInitial extends SearchEvent {}
