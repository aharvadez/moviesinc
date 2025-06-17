import 'package:moviesinc/core/localDb/genre_id.dart';
import 'package:moviesinc/core/localDb/movie_entity_db.dart';
import 'package:moviesinc/features/movies/repository/entities/genreEntityModel.dart';
import 'package:moviesinc/features/movies/repository/entities/movieEntityModel.dart';

class DBMovieMapper {
  MovieEntityFavouritesDB fromMovieEntityModel(MovieEntityModel model) {
    return MovieEntityFavouritesDB(
      movieId: model.id,
      title: model.title,
      year: model.year,
      genre: model.genre,
      rating: model.rating,
      posterUrl: model.posterUrl,
      overview: model.overview,
    );
  }

  List<MovieEntityFavouritesDB> fromMovieEntityModelList(
    List<MovieEntityModel> models,
  ) {
    return models.map(fromMovieEntityModel).toList();
  }

  MovieEntityModel fromDbEntityModel(MovieEntityFavouritesDB model) {
    return MovieEntityModel(
      id: model.movieId,
      title: model.title,
      year: model.year,
      genre: model.genre,
      rating: model.rating,
      posterUrl: model.posterUrl,
      overview: model.overview,
    );
  }

  List<MovieEntityModel> fromDbEntityModelList(
    List<MovieEntityFavouritesDB> models,
  ) {
    return models.map(fromDbEntityModel).toList();
  }

  GenreEntityModel fromGenreDBModel(GenreId model) {
    return GenreEntityModel(id: model.id, genre: model.genre);
  }

  List<GenreEntityModel> fromGenreDBModelList(List<GenreId> models) {
    return models.map(fromGenreDBModel).toList();
  }
}
