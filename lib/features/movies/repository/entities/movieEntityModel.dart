class MovieEntityModel {
  int id;
  final String title;
  final String year;
  final String genre;
  final double rating;
  final String posterUrl;
  final String overview;

  MovieEntityModel({
    required this.id,
    required this.title,
    required this.year,
    required this.genre,
    required this.rating,
    required this.posterUrl,
    required this.overview,
  });

  factory MovieEntityModel.fromJson(Map<String, dynamic> json) {
    return MovieEntityModel(
      id: json['id'],
      title: json['title'],
      year: json['year'],
      genre: json['genre'],
      rating: (json['rating'] as num).toDouble(),
      posterUrl: json['posterUrl'],
      overview: json['overview'],
    );
  }
}
