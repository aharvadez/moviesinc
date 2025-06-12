part of 'homepage_bloc.dart';

abstract class HomePageState {}

class HomePageInitial extends HomePageState {}

class HomePageLoading extends HomePageState {}

class HomePageLoaded extends HomePageState {
  final List<Map<String, dynamic>> movieList;

  HomePageLoaded(this.movieList);
}

class HomePageError extends HomePageState {
  final String error;

  HomePageError(this.error);
}
