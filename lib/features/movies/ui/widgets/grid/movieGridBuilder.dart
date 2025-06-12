import 'package:flutter/material.dart';
import 'package:moviesinc/features/movies/ui/common/movieCards/movieCard.dart';

class GridCreator extends StatelessWidget {
  const GridCreator({super.key, this.movieList});

  final List<Map<String, dynamic>>? movieList;
  @override
  Widget build(BuildContext context) {
    final hasMovies = movieList != null && movieList!.isNotEmpty;
    return GridView.builder(
      itemCount: hasMovies ? movieList!.length : 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2 / 3, // Width / Height
      ),
      itemBuilder: (context, index) {
        if (!hasMovies) {
          return const MovieCard(isLoading: true);
        }
        final movie = movieList![index];
        return MovieCard(
          title: movie['title'] as String,
          year: movie['year'] as String,
          genre: movie['genre'] as String,
          rating: movie['rating'] as double,
          posterUrl: movie['posterUrl'] as String,
        );
      },
    );
  }
}
