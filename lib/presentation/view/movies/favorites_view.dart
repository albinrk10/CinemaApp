import 'package:cinemapedia_albin/presentation/providers/providers.dart';
import 'package:cinemapedia_albin/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    ref.read(favoriteMoviesProvider.notifier).loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;

    final movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();

    isLoading = false;

    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();

    if (favoriteMovies.isEmpty) {
      final color = Theme.of(context).colorScheme;
      return  Center(
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center ,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.favorite_outline_sharp,size: 60,color:color.primary,),
            Text('Ohh no!!',style:TextStyle(fontSize: 30,color: color.primary)),
            const Text('No tienes peliculas favoritas',style:TextStyle(fontSize: 20,color: Colors.black45)),
            const SizedBox( height:20),
            FilledButton.tonal(
              onPressed: () => context.go('/home/0'),
               child: const Text('Empieza a busca'))
          ],
        )
      );
    }

    return Scaffold(
        body: SizedBox(
      height: MediaQuery.of(context).size.height - 80,
      child: MovieMasonry(
        loadNextPage: loadNextPage,
        movies: favoriteMovies,
      ),
    ));
  }
}
