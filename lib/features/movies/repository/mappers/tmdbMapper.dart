import 'package:moviesinc/core/api/network_models/tmdbNetworkModels.dart';
import 'package:moviesinc/features/movies/repository/db_repository.dart';
import 'package:moviesinc/features/movies/repository/entities/genreEntityModel.dart';
import 'package:moviesinc/features/movies/repository/entities/movieEntityModel.dart';

class Tmdbmapper {
  // final favMovieList = SaveFavoriteMovie().getFavoriteMovies();
  MovieEntityModel fromTmdbNetworkModel(TmdbMovieNetworkModel model) {
    List<GenreEntityModel> genreModelList = MaintainGenreIds().getGenreIds();

    List<String> genreNames = [];

    for (String id in model.genre) {
      final matchedGenre = genreModelList.firstWhere(
        (genreModel) => genreModel.id.toString() == id,
        orElse: () => GenreEntityModel(id: 0, genre: 'Thriller'),
      );
      genreNames.add(matchedGenre.genre);
    }

    return MovieEntityModel(
      id: int.parse(model.id),
      title: model.title,
      year: model.releaseDate.split('-')[0],
      genre: genreNames.join(', '),
      rating: model.rating,
      posterUrl: model.posterPath,
      overview: model.overview,
    );
  }

  List<MovieEntityModel> fromTmdbNetworkModelList(
    List<TmdbMovieNetworkModel> models,
  ) {
    return models.map(fromTmdbNetworkModel).toList();
  }

  GenreEntityModel fromGenreNetworkModel(GenreNetworkModel model) {
    return GenreEntityModel(id: model.id, genre: model.genre);
  }

  List<GenreEntityModel> fromGenreNetworkModelList(
    List<GenreNetworkModel> models,
  ) {
    return models.map(fromGenreNetworkModel).toList();
  }
}
