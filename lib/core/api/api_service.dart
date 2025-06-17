import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: dotenv.env['API_URL'] ?? '',
      headers: {'accept': 'application/json'},
    ),
  );

  ApiService._internal() {
    _dio.interceptors.clear();
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = dotenv.env['ACCESS_TOKEN'];
          if (token == null) {
            throw Exception('ACCESS_TOKEN not found in .env');
          }
          options.headers['Authorization'] = 'Bearer $token';
          return handler.next(options);
        },
        onError: (DioException error, ErrorInterceptorHandler handler) async {
          final options = error.requestOptions;
          const maxAttempts = 15;
          int attempts = (options.extra['retry_attempt'] ?? 0) + 1;

          if (attempts < maxAttempts) {
            options.extra['retry_attempt'] = attempts;
            await Future.delayed(const Duration(milliseconds: 100));
            try {
              final response = await _dio.fetch(options);
              return handler.resolve(response);
            } catch (e) {
              return handler.next(error); // still failed, forward the error
            }
          }

          return handler.next(error); // max retry hit
        },
      ),
    );
  }

  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  String get baseUrl {
    final baseUrl = dotenv.env['API_URL'];
    if (baseUrl == null) {
      throw Exception('API_URL not found in .env');
    }
    return baseUrl;
  }

  Future<Map<String, dynamic>> fetchData(String path) async {
    final response = await _dio.get(path);
    return response.data;
  }

  Future<Map<String, dynamic>> fetchPopularMovies({int pageNumber = 1}) async {
    return fetchData('movie/popular?language=en-US&page=$pageNumber');
  }

  Future<Map<String, dynamic>> fetchSearchMovies({
    query,
    pageNumber = 1,
  }) async {
    return fetchData('search/movie?query=$query&page=$pageNumber');
  }

  Future<Map<String, dynamic>> getGenres() async {
    return fetchData('genre/movie/list?language=en');
  }
}
