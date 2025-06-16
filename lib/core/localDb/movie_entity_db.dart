import 'package:objectbox/objectbox.dart';

@Entity()
class MovieEntityFavouritesDB {
  @Id()
  int id;
  int movieId;
  final String title;
  final String year;
  final String genre;
  final double rating;
  final String posterUrl;
  MovieEntityFavouritesDB({
    this.id = 0,
    required this.movieId,
    required this.title,
    required this.year,
    required this.genre,
    required this.rating,
    required this.posterUrl,
  });
}
