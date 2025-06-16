import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesinc/features/movies/repository/entities/movieEntityModel.dart';
import 'package:moviesinc/features/movies/repository/movie_repository.dart';

part "homepage_event.dart";
part "homepage_state.dart";

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial()) {
    on<HomePageLoadEvent>((event, emit) async {
      emit(HomePageLoading());
      try {
        final movies = await GetPopularMovies().fetchMovies();

        emit(HomePageLoaded(movies));
      } catch (e) {
        emit(HomePageError("Failed to load movies: $e"));
      }
    });
  }
}
