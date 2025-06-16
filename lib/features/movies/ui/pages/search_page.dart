import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesinc/features/movies/bloc/search/search_bloc.dart';
import 'package:moviesinc/features/movies/ui/widgets/search/search_bar.dart';
import 'package:moviesinc/features/movies/ui/widgets/search/search_tile.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(),
      child: Scaffold(
        body: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return Stack(
              children: [
                SearchBarCust(),
                if (state is SearchStateLoading)
                  const Center(child: CircularProgressIndicator()),

                if (state is SearchStateLoaded)
                  Padding(
                    padding: const EdgeInsets.only(top: 80.0),
                    child: ListView.builder(
                      itemCount: state.movies.length,
                      itemBuilder: (context, index) {
                        final movie = state.movies[index];
                        return SearchResultTile(movie: movie);
                      },
                    ),
                  ),

                if (state is SearchStateError)
                  Center(child: Text(state.message)),
              ],
            );
          },
        ),
      ),
    );
  }
}
