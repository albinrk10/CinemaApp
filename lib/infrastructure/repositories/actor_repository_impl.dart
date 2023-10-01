import 'package:cinemapedia_albin/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia_albin/domain/entities/actor.dart';
import 'package:cinemapedia_albin/domain/repositories/actors_respository.dart';

class ActorRepositoryImpl extends ActorsRepository {
  final ActorsDatasource datasource;

  ActorRepositoryImpl(this.datasource);

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return datasource.getActorsByMovie(movieId);
  }
}
