import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesinc/features/movies/repository/movie_repository.dart';

part "homepage_event.dart";
part "homepage_state.dart";

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial()) {
    on<HomePageLoadEvent>((event, emit) async {
      emit(HomePageLoading());
      try {
        emit(HomePageError("Failed to load movies"));
        final movies = await GetPopularMovies().fetchMovies();
        final movieList = movies
            .map(
              (movie) => {
                "id": movie.id,
                "title": movie.title,
                "year": movie.year,
                "genre": movie.genre,
                "rating": movie.rating,
                "posterUrl": movie.posterUrl,
              },
            )
            .toList();
        emit(HomePageLoaded(movieList));
      } catch (e) {
        emit(HomePageError("Failed to load movies: $e"));
      }
    });
  }
}
