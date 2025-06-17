class GenreEntityModel {
  int id;
  final String genre;

  GenreEntityModel({required this.id, required this.genre});

  factory GenreEntityModel.fromJson(Map<String, dynamic> json) {
    return GenreEntityModel(id: json['id'], genre: json['genre']);
  }
}
