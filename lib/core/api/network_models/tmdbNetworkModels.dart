class TmdbMovieNetworkModel {
  final String id;
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final List<String> genre;
  final double rating;

  TmdbMovieNetworkModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.genre,
    required this.rating,
  });

  factory TmdbMovieNetworkModel.fromJson(Map<String, dynamic> json) {
    var obj = TmdbMovieNetworkModel(
      id: json['id'].toString(),
      title: json['original_title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'] ?? '',
      genre: json['genre_ids'] != null
          ? List<String>.from(json['genre_ids'].map((g) => g.toString()))
          : [],
      rating: (json['vote_average'] ?? 0).toDouble(),
    );
    return obj;
  }
}
