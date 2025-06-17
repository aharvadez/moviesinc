import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:moviesinc/features/movies/repository/db_repository.dart';
import 'package:moviesinc/features/movies/repository/entities/movieEntityModel.dart';
import 'package:moviesinc/features/movies/repository/movie_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  List<MovieEntityModel> _cachedRecommendations = [];

  SearchBloc() : super(SearchStateInitial(movies: [])) {
    //Event 1
    on<SearchEventLoadInitial>((event, emit) async {
      if (_cachedRecommendations.isNotEmpty) {
        emit(SearchStateInitial(movies: _cachedRecommendations));
        return;
      }
      emit(SearchStateLoading());
      final List<String> queries = maintainSearchParams().getSearchParams();
      final List<MovieEntityModel> movieList = [];
      for (String query in queries) {
        final data = await SearchMovies(
          query: query,
          pageNumber: 1,
        ).fetchData();

        movieList.add(await data[0]);
      }
      _cachedRecommendations = movieList;
      emit(SearchStateInitial(movies: _cachedRecommendations));
    });

    //Event 2
    on<SearchEventQueryChanged>((event, emit) async {
      final query = event.query.trim();
      if (query.isEmpty) {
        emit(SearchStateInitial(movies: _cachedRecommendations));
        return;
      }

      emit(SearchStateLoading());

      try {
        final data = await SearchMovies(
          query: query,
          pageNumber: 1,
        ).fetchData();

        if (data.isEmpty) {
          emit(SearchStateLoaded(movies: []));
          return;
        }

        maintainSearchParams().saveSeacrhParams(query);
        _cachedRecommendations.add(await data[0]);
        emit(SearchStateLoaded(movies: data));
      } catch (e) {
        emit(SearchStateError(message: "Failed to search"));
      }
    });
  }
}
