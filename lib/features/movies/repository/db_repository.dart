import 'package:moviesinc/core/localDb/movie_entity_db.dart';
import 'package:moviesinc/features/movies/repository/entities/movieEntityModel.dart';
import 'package:moviesinc/features/movies/repository/mappers/db_movie_mapper.dart';
import 'package:moviesinc/main.dart';
import 'package:moviesinc/objectbox.g.dart';

class SaveFavoriteMovie {
  final DBMovieMapper _mapper = DBMovieMapper();
  List<MovieEntityModel> getFavoriteMovies() {
    List<MovieEntityFavouritesDB> movieDbList = objectBox.movieBox.getAll();
    return _mapper.fromDbEntityModelList(movieDbList);
  }

  void addMovie(MovieEntityModel movie) {
    final exists = objectBox.movieBox
        .query(MovieEntityFavouritesDB_.movieId.equals(movie.id))
        .build()
        .findFirst();
    if (exists == null) {
      final movieDB = _mapper.fromMovieEntityModel(movie);
      objectBox.movieBox.put(movieDB);
    }
  }

  void deleteMovie(MovieEntityModel movie) {
    final movieToRemove = objectBox.movieBox
        .query(MovieEntityFavouritesDB_.movieId.equals(movie.id))
        .build()
        .findFirst();
    if (movieToRemove != null) {
      objectBox.movieBox.remove(movieToRemove.id);
    }
  }
}
