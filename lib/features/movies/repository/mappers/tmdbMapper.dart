import 'package:moviesinc/core/api/network_models/tmdbNetworkModels.dart';
import 'package:moviesinc/features/movies/repository/entities/movieEntityModel.dart';

class Tmdbmapper {
  MovieEntityModel fromTmdbNetworkModel(TmdbMovieNetworkModel model) {
    return MovieEntityModel(
      id: model.id,
      title: model.title,
      year: model.releaseDate.split('-')[0],
      genre: model.genre.join(', '),
      rating: model.rating,
      posterUrl: model.posterPath,
    );
  }

  List<MovieEntityModel> fromTmdbNetworkModelList(
    List<TmdbMovieNetworkModel> models,
  ) {
    return models.map(fromTmdbNetworkModel).toList();
  }
}
