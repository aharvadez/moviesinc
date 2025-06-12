import 'package:flutter/material.dart';
import 'package:moviesinc/features/movies/ui/common/movieCards/movieCard.dart';

class MovieCardCarousel extends StatelessWidget {
  const MovieCardCarousel({
    super.key,
    required this.movieList,
    this.loading = false,
  });

  final List<Map<String, dynamic>> movieList;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: PageController(viewportFraction: 0.4),
      padEnds: false,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        if (loading) {
          return MovieCard(isLoading: true);
        }
        final movie = movieList[index % movieList.length];
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
