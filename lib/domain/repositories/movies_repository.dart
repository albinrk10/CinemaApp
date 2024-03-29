import '../entities/entities.dart';

abstract class MoviesRepository {
  Future<List<Movie>>getNowPlaying({int page = 1});
    //*Proximamente
    Future<List<Movie>>getUpcoming({int page = 1});
   //*Polular
   Future<List<Movie>>getPopular({int page = 1});
   //*Mejor Calificada
   Future<List<Movie>>getTopRated({int page = 1});

   Future<Movie> getMovieById(String id);

    Future<List<Movie>> searchMovies(String query);

    Future<List<Movie>> getSimilarMovies( int movieId );

    Future<List<Video>> getYoutubeVideosById(int movieId);
}
