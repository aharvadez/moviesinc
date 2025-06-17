import 'package:moviesinc/core/api/api_service.dart';
import 'package:moviesinc/core/api/network_models/tmdbNetworkModels.dart';
import 'package:moviesinc/features/movies/repository/entities/genreEntityModel.dart';
import 'package:moviesinc/features/movies/repository/entities/movieEntityModel.dart';
import 'package:moviesinc/features/movies/repository/mappers/tmdbMapper.dart';

class GetPopularMovies {
  final ApiService apiRequest = ApiService();
  final Tmdbmapper mapper = Tmdbmapper();

  Future<List<MovieEntityModel>> fetchMovies({int pageNumber = 1}) async {
    final response = await apiRequest.fetchPopularMovies(
      pageNumber: pageNumber,
    );
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

  final apiRequest = ApiService();
  final Tmdbmapper mapper = Tmdbmapper();

  Future<List<MovieEntityModel>> fetchData() async {
    final response = await apiRequest.fetchSearchMovies(query: query);
    final List<TmdbMovieNetworkModel> movies = (response['results'] as List)
        .map((e) => TmdbMovieNetworkModel.fromJson(e))
        .toList();

    return mapper.fromTmdbNetworkModelList(movies);
  }
}

class GetGenreData {
  final ApiService apiRequest = ApiService();
  final Tmdbmapper mapper = Tmdbmapper();

  Future<List<GenreEntityModel>> fetchGenres() async {
    final response = await apiRequest.getGenres();
    final List<GenreNetworkModel> genres = (response['genres'] as List)
        .map((e) => GenreNetworkModel.fromJson(e))
        .toList();

    // var finalList =

    // Map<int, String> finalMap = {};

    // for (var item in finalList) {
    //   finalMap[item.id] = item.genre;
    // }

    return mapper.fromGenreNetworkModelList(genres);
  }
}
