import './../../objectbox.g.dart';
import '../localDb/movie_entity_db.dart';
import 'package:path_provider/path_provider.dart';

class ObjectBox {
  late final Store store;
  late final Box<MovieEntityFavouritesDB> movieBox;

  ObjectBox._create(this.store) {
    movieBox = Box<MovieEntityFavouritesDB>(store);
  }

  static Future<ObjectBox> create() async {
    final dir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: '${dir.path}/objectbox');
    return ObjectBox._create(store);
  }
}
