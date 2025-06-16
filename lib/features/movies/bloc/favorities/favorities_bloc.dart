import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moviesinc/features/movies/repository/db_repository.dart';
import 'package:moviesinc/features/movies/repository/entities/movieEntityModel.dart';

part 'favorities_event.dart';
part 'favorities_state.dart';

class FavoritiesBloc extends Bloc<FavoritiesEvent, FavoritiesState> {
  final favMovieHandler = SaveFavoriteMovie();
  late final List<MovieEntityModel> favMovieList;

  FavoritiesBloc() : super(FavoritiesInitial([])) {
    final initialFavs = favMovieHandler.getFavoriteMovies();
    favMovieList = List<MovieEntityModel>.from(initialFavs);
    emit(FavoritiesInitial(List.from(favMovieList)));

    on<TriggerAddToFavoritiesEvent>((event, emit) {
      final isFavorite = favMovieList.any((m) => m.id == event.movie.id);

      if (isFavorite) {
        favMovieHandler.deleteMovie(event.movie);
        favMovieList.removeWhere((m) => m.id == event.movie.id);
      } else {
        favMovieHandler.addMovie(event.movie);
        favMovieList.add(event.movie);
      }

      emit(FavoritiesTriggered(List.from(favMovieList)));
    });
  }
}
