import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesinc/features/movies/bloc/search/search_bloc.dart';
import 'package:moviesinc/features/movies/ui/widgets/grid/movieGridBuilder.dart';
import 'package:moviesinc/features/movies/ui/widgets/search/search_bar.dart';
import 'package:moviesinc/features/movies/ui/widgets/search/search_tile.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = SearchBloc();
        bloc.add(SearchEventLoadInitial()); // trigger initial search load
        return bloc;
      },
      child: Scaffold(
        body: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return Column(
              children: [
                SearchBarCust(), // outside BlocBuilder - will not rebuild
                Expanded(
                  child: BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      if (state is SearchStateLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is SearchStateInitial) {
                        final movies = state.movies;
                        if (movies.isEmpty) {
                          return Center(child: Text("No Movies Found"));
                        }
                        return GridCreator(
                          movieList: movies.length <= 4
                              ? movies.reversed.toList()
                              : movies
                                    .sublist(movies.length - 4)
                                    .reversed
                                    .toList(),
                        );
                      } else if (state is SearchStateLoaded) {
                        if (state.movies.isEmpty) {
                          return const Center(child: Text("No movies found."));
                        } else {
                          return ListView.builder(
                            itemCount: state.movies.length,
                            itemBuilder: (context, index) {
                              return SearchResultTile(
                                movie: state.movies[index],
                              );
                            },
                          );
                        }
                      } else if (state is SearchStateError) {
                        return Center(child: Text(state.message));
                      }
                      return SizedBox(); // fallback
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
