import 'package:moviesinc/core/localDb/movie_entity_db.dart';
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
    );
  }

  List<MovieEntityModel> fromDbEntityModelList(
    List<MovieEntityFavouritesDB> models,
  ) {
    return models.map(fromDbEntityModel).toList();
  }
}
