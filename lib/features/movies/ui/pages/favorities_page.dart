import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviesinc/features/movies/bloc/favorities/favorities_bloc.dart';
import 'package:moviesinc/features/movies/repository/db_repository.dart';
import 'package:moviesinc/features/movies/repository/entities/movieEntityModel.dart';
import 'package:moviesinc/features/movies/ui/widgets/grid/movieGridBuilder.dart';

class FavoritiesPage extends StatefulWidget {
  const FavoritiesPage({super.key});

  @override
  State<FavoritiesPage> createState() => _FavoritiesPageState();
}

class _FavoritiesPageState extends State<FavoritiesPage> {
  late List<MovieEntityModel> movieListFromDB = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadMovies();
  }

  void loadMovies() {
    final movies = SaveFavoriteMovie().getFavoriteMovies();
    setState(() {
      movieListFromDB = movies;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FavoritiesBloc, FavoritiesState>(
        builder: (context, state) {
          if (state is FavoritiesInitial) {
            if (state.favMovieList.isNotEmpty) {
              return GridCreator(movieList: state.favMovieList);
            }
          } else if (state is FavoritiesTriggered) {
            if (state.favMovieList.isNotEmpty) {
              return GridCreator(movieList: state.favMovieList);
            }
          } else {
            return Center(child: Text("No Favorities Found."));
          }
          return Center(child: Text("No Favorities Found."));
        },
      ),
    );
  }
}
