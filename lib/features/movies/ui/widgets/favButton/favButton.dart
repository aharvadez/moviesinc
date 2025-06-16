import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesinc/features/movies/bloc/favorities/favorities_bloc.dart';
import 'package:moviesinc/features/movies/repository/db_repository.dart';
import 'package:moviesinc/features/movies/repository/entities/movieEntityModel.dart';

class Favbutton extends StatelessWidget {
  const Favbutton({super.key, required this.movie});

  final MovieEntityModel movie;
  @override
  Widget build(BuildContext context) {
    final favList = SaveFavoriteMovie().getFavoriteMovies();
    return IconButton(
      icon: BlocBuilder<FavoritiesBloc, FavoritiesState>(
        builder: (context, state) {
          if (state is FavoritiesTriggered) {
            final isFav = state.favMovieList.any((m) => m.id == movie.id);
            return Icon(isFav ? Icons.favorite : Icons.favorite_border);
          } else if (state is FavoritiesInitial) {
            final bool isFav = favList.any((m) => m.id == movie.id);
            return Icon(isFav ? Icons.favorite : Icons.favorite_border);
          } else {
            return Icon(Icons.favorite);
          }
        },
      ),
      iconSize: 20,
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(),
      onPressed: () {
        context.read<FavoritiesBloc>().add(TriggerAddToFavoritiesEvent(movie));
      },
    );
  }
}
