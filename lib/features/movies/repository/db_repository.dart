import 'package:moviesinc/core/localDb/genre_id.dart';
import 'package:moviesinc/core/localDb/movie_entity_db.dart';
import 'package:moviesinc/core/localDb/search_params.dart';
import 'package:moviesinc/features/movies/repository/entities/genreEntityModel.dart';
import 'package:moviesinc/features/movies/repository/entities/movieEntityModel.dart';
import 'package:moviesinc/features/movies/repository/mappers/db_movie_mapper.dart';
import 'package:moviesinc/features/movies/repository/movie_repository.dart';
import 'package:moviesinc/main.dart';
import 'package:moviesinc/objectbox.g.dart';

class SaveFavoriteMovie {
  final DBMovieMapper _mapper = DBMovieMapper();
  List<MovieEntityModel> getFavoriteMovies() {
    List<MovieEntityFavouritesDB> movieDbList = objectBox.movieBox.getAll();
    return _mapper.fromDbEntityModelList(movieDbList);
  }

  void addMovie(MovieEntityModel movie) {
    final exists = objectBox.movieBox
        .query(MovieEntityFavouritesDB_.movieId.equals(movie.id))
        .build()
        .findFirst();
    if (exists == null) {
      final movieDB = _mapper.fromMovieEntityModel(movie);
      objectBox.movieBox.put(movieDB);
    }
  }

  void deleteMovie(MovieEntityModel movie) {
    final movieToRemove = objectBox.movieBox
        .query(MovieEntityFavouritesDB_.movieId.equals(movie.id))
        .build()
        .findFirst();
    if (movieToRemove != null) {
      objectBox.movieBox.remove(movieToRemove.id);
    }
  }
}

class maintainSearchParams {
  List<String> getSearchParams() {
    List<SearchParamsDB> searchParamDbList = objectBox.searchBox.getAll();
    int start = searchParamDbList.length > 4 ? searchParamDbList.length - 4 : 0;

    return searchParamDbList
        .sublist(start)
        .reversed
        .map((e) => e.query)
        .toList();
  }

  void saveSeacrhParams(String query) {
    final exists = objectBox.searchBox
        .query(SearchParamsDB_.query.equals(query))
        .build()
        .findFirst();

    if (exists == null) {
      final newSearch = SearchParamsDB(query: query);
      objectBox.searchBox.put(newSearch);
    }
  }
}

class MaintainGenreIds {
  void saveGenreIds() async {
    var genreList = await GetGenreData().fetchGenres();

    for (GenreEntityModel genre in genreList) {
      final query = objectBox.genreBox
          .query(GenreId_.id.equals(genre.id))
          .build();

      final exists = query.findFirst();
      query.close();
      if (exists == null) {
        objectBox.genreBox.put(GenreId(remoteId: genre.id, genre: genre.genre));
      }
    }
  }

  List<GenreEntityModel> getGenreIds() {
    List<GenreEntityModel> genreListMapped = DBMovieMapper()
        .fromGenreDBModelList(objectBox.genreBox.getAll());
    return genreListMapped;
  }
}
