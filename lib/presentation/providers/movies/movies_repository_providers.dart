import 'package:cinemapedia_albin/infrastructure/datasources/moviedb_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infrastructure/repositories/movie_repository_impl.dart';

//Este repositorio es inmutable
final movieRespositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(MoviedbDatasource());
});
