part of 'homepage_bloc.dart';

abstract class HomePageState {}

class HomePageInitial extends HomePageState {}

class HomePageLoading extends HomePageState {}

class HomePageLoaded extends HomePageState {
  final List<MovieEntityModel> movieList;
  final bool hasReachedMax;
  HomePageLoaded({required this.movieList, required this.hasReachedMax});
}

class HomePageError extends HomePageState {
  final String error;

  HomePageError(this.error);
}
