import 'package:moviesinc/core/api/api_service.dart';
import 'package:moviesinc/core/api/network_models/tmdbNetworkModels.dart';
import 'package:moviesinc/features/movies/repository/entities/movieEntityModel.dart';
import 'package:moviesinc/features/movies/repository/mappers/tmdbMapper.dart';

class GetPopularMovies {
  final PopularMoviesApiRequest apiRequest = PopularMoviesApiRequest();
  final Tmdbmapper mapper = Tmdbmapper();

  Future<List<MovieEntityModel>> fetchMovies() async {
    final response = await apiRequest.fetchData();
    final List<TmdbMovieNetworkModel> movies = (response['results'] as List)
        .map((e) => TmdbMovieNetworkModel.fromJson(e))
        .toList();

    return mapper.fromTmdbNetworkModelList(movies);
  }
}

class SearchMovies {
  SearchMovies({required this.query, this.pageNumber = 1});
  final String query;
  final int pageNumber;

  final apiRequest = MoviesSearchApiRequest();
  final Tmdbmapper mapper = Tmdbmapper();

  Future<List<MovieEntityModel>> fetchData() async {
    final response = await apiRequest.fetchData(query: query);
    final List<TmdbMovieNetworkModel> movies = (response['results'] as List)
        .map((e) => TmdbMovieNetworkModel.fromJson(e))
        .toList();

    return mapper.fromTmdbNetworkModelList(movies);
  }
}
