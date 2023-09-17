import 'package:cinemapedia_albin/presentation/providers/providers.dart';
import 'package:cinemapedia_albin/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    //*Proximamente
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    //*Polular
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    //*Mejor Calificada
    ref.read(topratedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    //final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    // if (nowPlayingMovies.length == 0) return CircularProgressIndicator();

    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullScreenLoader();

    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    //*Proximamente
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    //*Polular
    final popularMovies = ref.watch(popularMoviesProvider);
    //*Mejor Calificada
    final topratedMovies = ref.watch(topratedMoviesProvider);

    return CustomScrollView(
      slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          //centerTitle: true,
          titlePadding: EdgeInsets.all(0),
          title: CustomAppbar(),
        ),
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            MoviesSlideshow(movies: slideShowMovies),
            MovieHorizontalListView(
                movies: nowPlayingMovies,
                titile: 'En cines',
                subTitle: 'Lunes 20',
                loadNextPage: () =>
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage()),
            MovieHorizontalListView(
                movies: upcomingMovies,
                titile: 'Proximamente',
                subTitle: 'En este mes',
                loadNextPage: () =>
                    ref.read(upcomingMoviesProvider.notifier).loadNextPage()),
            MovieHorizontalListView(
                movies: popularMovies,
                titile: 'Populares',
                //subTitle: '',
                loadNextPage: () =>
                    ref.read(popularMoviesProvider.notifier).loadNextPage()),
            MovieHorizontalListView(
                movies: topratedMovies,
                titile: 'Mejor calificadas',
                subTitle: 'Desde siempre',
                loadNextPage: () =>
                    ref.read(topratedMoviesProvider.notifier).loadNextPage()),
            const SizedBox(
              height: 10,
            )
          ],
        );
      }, childCount: 1))
    ]);
  }
}
