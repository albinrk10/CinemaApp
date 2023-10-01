import 'package:cinemapedia_albin/domain/entities/actor.dart';
import 'package:cinemapedia_albin/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';
import '../../config/constants/environment.dart';
import '../../domain/datasources/actors_datasource.dart';
import '../mappers/actor_mapper.dart';

class ActorMovieDbDatasource extends ActorsDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Enviroment.theMovieDBKey,
        'language': 'es-MX'
      }));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('movie/$movieId/credits');

    final castResponse = CreditsResponse.fromJson(response.data);

    List<Actor> actors = castResponse.cast
        .map((cast) => ActorMapper.castYoEntity(cast))
        .toList();

    return actors;
  }
}
