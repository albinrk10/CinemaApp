import 'package:cinemapedia_albin/domain/datasources/movies_datasource.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/movies_repository.dart';


class MovieRepositoryImpl extends MoviesRepository {
  
  final MovieDatasource datasource;

  MovieRepositoryImpl(this.datasource);
  

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }
}
