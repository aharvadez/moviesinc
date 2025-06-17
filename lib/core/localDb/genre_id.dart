import 'package:objectbox/objectbox.dart';

@Entity()
class GenreId {
  @Id()
  int id;
  int remoteId;
  String genre;
  GenreId({this.id = 0, required this.remoteId, required this.genre});
}
