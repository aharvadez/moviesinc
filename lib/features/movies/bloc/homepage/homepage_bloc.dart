import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesinc/features/movies/repository/entities/movieEntityModel.dart';
import 'package:moviesinc/features/movies/repository/movie_repository.dart';

part "homepage_event.dart";
part "homepage_state.dart";

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  int _page = 1;
  final int _limit = 20;
  bool _hasReachedMax = false;

  HomePageBloc() : super(HomePageInitial()) {
    on<HomePageLoadEvent>((event, emit) async {
      if (_hasReachedMax || state is HomePageLoading) return;
      try {
        if (state is HomePageInitial) {
          emit(HomePageLoading());
          final movies = await GetPopularMovies().fetchMovies(
            pageNumber: _page,
          );
          _hasReachedMax = movies.length < _limit;
          emit(
            HomePageLoaded(movieList: movies, hasReachedMax: _hasReachedMax),
          );
        } else if (state is HomePageLoaded) {
          _page++;
          final currentState = state as HomePageLoaded;
          final movies = await GetPopularMovies().fetchMovies(
            pageNumber: _page,
          );
          _hasReachedMax = movies.length < _limit;
          emit(
            HomePageLoaded(
              movieList: currentState.movieList + movies,
              hasReachedMax: _hasReachedMax,
            ),
          );
        }
      } catch (e) {
        emit(HomePageError("Failed to load movies: $e"));
      }
    });
  }
}
