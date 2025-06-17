import 'package:moviesinc/core/localDb/genre_id.dart';
import 'package:moviesinc/core/localDb/search_params.dart';

import './../../objectbox.g.dart';
import '../localDb/movie_entity_db.dart';
import 'package:path_provider/path_provider.dart';

class ObjectBox {
  late final Store store;
  late final Box<MovieEntityFavouritesDB> movieBox;
  late final Box<SearchParamsDB> searchBox;
  late final Box<GenreId> genreBox;

  ObjectBox._create(this.store) {
    movieBox = Box<MovieEntityFavouritesDB>(store);
    searchBox = Box<SearchParamsDB>(store);
    genreBox = Box<GenreId>(store);
  }

  static Future<ObjectBox> create() async {
    final dir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: '${dir.path}/objectbox');
    return ObjectBox._create(store);
  }
}
