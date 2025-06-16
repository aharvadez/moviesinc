import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:moviesinc/features/movies/repository/entities/movieEntityModel.dart';
import 'package:moviesinc/features/movies/repository/movie_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchStateInitial()) {
    on<SearchEventQueryChanged>((event, emit) async {
      final query = event.query.trim();
      if (query.isEmpty) {
        emit(SearchStateInitial());
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

        emit(SearchStateLoaded(movies: data));
      } catch (e) {
        emit(SearchStateError(message: "Failed to search"));
      }
    });
  }
}
