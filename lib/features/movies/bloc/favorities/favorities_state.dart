part of 'favorities_bloc.dart';

@immutable
sealed class FavoritiesState {}

final class FavoritiesInitial extends FavoritiesState {
  final List<MovieEntityModel> favMovieList;
  FavoritiesInitial(this.favMovieList);
}

final class FavoritiesTriggered extends FavoritiesState {
  final List<MovieEntityModel> favMovieList;

  FavoritiesTriggered(this.favMovieList);
}
