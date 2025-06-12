import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final Dio dio = Dio();

void setDioAuthorizationHeader() {
  if (!dio.options.headers.containsKey('Authorization')) {
    final token = dotenv.env['ACCESS_TOKEN'];
    if (token == null) {
      throw Exception('ACCESS_TOKEN not found in .env');
    }
    dio.options.headers['accept'] = 'application/json';
    dio.options.headers['Authorization'] = 'Bearer $token';
  }
}

// void setDioAuthorizationHeader() {
//   if (!dio.options.headers.containsKey('Authorization')) {
//     final token = dotenv.env['ACCESS_TOKEN'];
//     if (token == null) {
//       throw Exception('ACCESS_TOKEN not found in .env');
//     }
//     dio.options.headers['accept'] = 'application/json';
//     dio.options.headers['Authorization'] = 'Bearer $token';
//   }
// }

class MoviesSearchApiRequest {
  MoviesSearchApiRequest();

  String url(String query, {int pageNumber = 1}) {
    final baseUrl = dotenv.env['API_URL'];

    return '${baseUrl}search/movie?query=$query&page=$pageNumber';
  }

  Future<Map<String, dynamic>> fetchData({
    int pageNumber = 1,
    required String query,
  }) async {
    setDioAuthorizationHeader();
    try {
      final response = await dio.get(url(query, pageNumber: pageNumber));
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }
}

class PopularMoviesApiRequest {
  String get url {
    final baseUrl = dotenv.env['API_URL'];

    return '${baseUrl}movie/popular?language=en-US&page=1';
  }

  Future<Map<String, dynamic>> fetchData({int pageNumber = 1}) async {
    setDioAuthorizationHeader();
    try {
      var response = await dio.get(url);

      // print(response.data);
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }
}
