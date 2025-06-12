import 'package:flutter/material.dart';
import 'package:moviesinc/features/movies/repository/movie_repository.dart';
import 'package:moviesinc/features/movies/ui/widgets/grid/movieGridBuilder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>>? _movieList;

  @override
  void initState() {
    super.initState();

    _fetchMovies();
  }

  Future<void> _fetchMovies() async {
    try {
      final movies = await GetPopularMovies().fetchMovies();
      setState(() {
        _movieList = movies
            .map(
              (movie) => {
                "id": movie.id,
                "title": movie.title,
                "year": movie.year,
                "genre": movie.genre,
                "rating": movie.rating,
                "posterUrl": movie.posterUrl,
              },
            )
            .toList();
      });
    } catch (e) {
      throw Exception("Failed to fetch movies: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GridCreator(movieList: _movieList));
  }
}
