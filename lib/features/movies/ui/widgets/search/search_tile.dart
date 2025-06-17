import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:moviesinc/features/movies/repository/entities/movieEntityModel.dart';
import 'package:moviesinc/features/movies/ui/common/movieCards/fullScreenMovieCard.dart';
import 'package:moviesinc/features/movies/ui/widgets/favButton/favButton.dart';

class SearchResultTile extends StatelessWidget {
  final MovieEntityModel movie;

  const SearchResultTile({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 4,
      child: ListTile(
        leading: Hero(
          tag: 'movie_${movie.id}',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              dotenv.env['TMDB_IMAGE_BASE_URL']! + movie.posterUrl,
              width: 40,
              height: 75,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
            ),
          ),
        ),
        title: Text(
          movie.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${movie.genre} | ${movie.year}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 18),
            Text(movie.rating.toStringAsFixed(1)),
            Favbutton(movie: movie),
          ],
        ),
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              opaque: false,
              barrierColor: Colors.black.withOpacity(0.9),
              transitionDuration: const Duration(milliseconds: 400),
              pageBuilder: (_, __, ___) => FullScreenMovieCard(movie: movie),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
            ),
          );
        },
      ),
    );
  }
}
