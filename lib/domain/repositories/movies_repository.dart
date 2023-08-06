import '../entities/movie.dart';

//Servicio
abstract class MovieDatasource {
  Future<List<Movie>>getNowPlaying({int page =1});
}
