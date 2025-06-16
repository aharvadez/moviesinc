import 'package:flutter/material.dart';
import 'package:moviesinc/features/movies/repository/entities/movieEntityModel.dart';
import 'package:moviesinc/features/movies/ui/common/movieCards/movieCard.dart';

class MovieCardCarousel extends StatelessWidget {
  const MovieCardCarousel({
    super.key,
    required this.movieList,
    this.loading = false,
  });

  final List<MovieEntityModel> movieList;
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
        return MovieCard(movie: movie, isLoading: false);
      },
    );
  }
}
