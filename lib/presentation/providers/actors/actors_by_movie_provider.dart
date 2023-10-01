import 'package:cinemapedia_albin/domain/entities/actor.dart';
import 'package:cinemapedia_albin/presentation/providers/actors/actors_repository_provide.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final actorsByMovieProvider = StateNotifierProvider<ActorsByMovieNotifier, Map <String, List<Actor>>>((ref) {
  final actorsRepository = ref.watch(actorsRepositoryProvider);

  return ActorsByMovieNotifier(getActors: actorsRepository.getActorsByMovie);
});
/*
{
  '505642:<Actor>[],
  '505645:<Actor>[],
  '505644:<Actor>[],
}
*/

typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallback getActors;

  ActorsByMovieNotifier({required this.getActors}) : super({});

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;

    final List <Actor> actors = await getActors(movieId);
    state = {...state, movieId: actors};
  }
}
