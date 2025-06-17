part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchStateInitial extends SearchState {
  // final bool isLoaded;
  final List<MovieEntityModel> movies;

  SearchStateInitial({required this.movies});
}

final class SearchStateLoading extends SearchState {}

final class SearchStateLoaded extends SearchState {
  final List<MovieEntityModel> movies;
  final int pageNumber;

  SearchStateLoaded({required this.movies, this.pageNumber = 1});
}

final class SearchStateError extends SearchState {
  final String message;

  SearchStateError({required this.message});
}
