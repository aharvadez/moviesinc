import 'package:flutter/material.dart';
import 'package:moviesinc/features/movies/repository/entities/movieEntityModel.dart';
import 'package:moviesinc/features/movies/ui/common/movieCards/movieCard.dart';

class GridCreator extends StatelessWidget {
  const GridCreator({
    super.key,
    this.movieList,
    this.scrollController,
    this.isLoadingMore = false,
  });

  final List<MovieEntityModel>? movieList;
  final ScrollController? scrollController;
  final bool isLoadingMore;

  @override
  Widget build(BuildContext context) {
    final hasMovies = movieList != null && movieList!.isNotEmpty;
    final movieTiles = hasMovies
        ? movieList!.map((movie) => MovieCard(movie: movie)).toList()
        : List.generate(6, (_) => const MovieCard(isLoading: true));

    return ListView(
      controller: scrollController,
      padding: const EdgeInsets.all(10),
      children: [
        GridView.count(
          physics:
              const NeverScrollableScrollPhysics(), // Disable nested scrolling
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 2 / 3,
          children: movieTiles,
        ),
        if (isLoadingMore)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}
