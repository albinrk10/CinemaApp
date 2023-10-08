import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/movie.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovies;

  SearchMovieDelegate({required this.searchMovies});

  @override
  String get searchFieldLabel => 'Buscar peliculas';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      // if(query.isNotEmpty)
      FadeIn(
        animate: query.isNotEmpty,
        child: IconButton(
            onPressed: () => query = '', icon: const Icon(Icons.clear)),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back_ios_new_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
        future: searchMovies(query),
        initialData: const [],
        builder: (context, snapshot) {
          final movies = snapshot.data ?? [];

          return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) =>
                  _MovieItem(movie: movies[index]));
        });
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  const _MovieItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    final texStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          // Image
          SizedBox(
            width: size.width * 0.2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
                child:Image.network(
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) => FadeIn(child: child),
                  ),

              ),
            ),
            const SizedBox(width: 10),         

          //Descripcion
          SizedBox(
            width: size.width*0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title,style:texStyles.titleMedium),

                (movie.overview.length > 100)
                ? Text('${movie.overview.substring(0,100)}...')
                :Text(movie.overview) ,
                

              ],
            ),
          )
        ],
      ),
    );
  }
}
