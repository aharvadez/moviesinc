import 'package:objectbox/objectbox.dart';

@Entity()
class SearchParamsDB {
  @Id()
  int id;
  String query;
  SearchParamsDB({this.id = 0, required this.query});
}
