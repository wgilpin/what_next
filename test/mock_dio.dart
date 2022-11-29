import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mocktail/mocktail.dart';
import 'mock_tmdb_data.dart';

class MockDio extends Mock implements Dio {
  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    // is this a TV or movie query?
    dynamic results;
    if (path.contains('/search/movie')) {
      debugPrint('movie query');
      results = tmdbMockSearchResultsMovie;
    } else if (path.contains('/search/tv')) {
      debugPrint('tv query');
      results = tmdbMockSearchResultsTV;
    } else if (path.contains('/genre/')) {
      debugPrint('genre query');
      results = tmdbMockGenreList;
    } else {
      throw Exception('MockDio: unknown path: $path');
    }
    // debugPrint('return result ${results.toString()}');

    return Future.value(Response<T>(
      requestOptions: RequestOptions(path: path),
      data: results,
    ));
  }
}
