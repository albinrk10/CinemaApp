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
  }

  @override
  Widget build(BuildContext context) {
    //final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    // if (nowPlayingMovies.length == 0) return CircularProgressIndicator();
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            //centerTitle: true,
            titlePadding: EdgeInsets.all(0),
             title:  CustomAppbar(),
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
                movies: nowPlayingMovies,
                titile: 'Proximamente',
                subTitle: 'En este mes',
                loadNextPage: () =>
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage()),
            MovieHorizontalListView(
                movies: nowPlayingMovies,
                titile: 'Populares',
                //subTitle: '',
                loadNextPage: () =>
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage()),
            MovieHorizontalListView(
                movies: nowPlayingMovies,
                titile: 'Mejor calificadas',
                subTitle: 'Desde siempre',
                loadNextPage: () =>
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage()),
            const SizedBox(
              height: 10,
            )
          ],
        );
      }, childCount: 10))
    ]);
  }
}
