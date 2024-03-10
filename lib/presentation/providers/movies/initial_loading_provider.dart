import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  final step1 = ref.watch(nowPlayingMoviesProvider).isEmpty;
  //*Proximamente
  final step2 = ref.watch(upcomingMoviesProvider).isEmpty;
  //*Polular
  final step3 = ref.watch(popularMoviesProvider).isEmpty;
  //*Mejor Calificada
  final step4 = ref.watch(topRatedMoviesProvider).isEmpty;
  if (step1 ||step2 || step3 || step4 ) return true;
  return false; //terminamos de cargar
});
