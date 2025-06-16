import 'package:flutter/material.dart';
import 'package:moviesinc/features/movies/repository/entities/movieEntityModel.dart';
import 'package:moviesinc/features/movies/ui/widgets/carousel/carouselDescriptor.dart';
import 'package:moviesinc/features/movies/ui/widgets/carousel/movieCardCarousel.dart';

class CarouselCreator extends StatelessWidget {
  const CarouselCreator({super.key, required this.movieList});
  final List<MovieEntityModel>? movieList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselDescriptor(genere: "Sci-Fi"),
        SizedBox(
          height: 300,
          child: MovieCardCarousel(
            movieList: movieList ?? [],
            loading: movieList == null,
          ),
        ),
      ],
    );
  }
}
