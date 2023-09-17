import 'package:flutter/material.dart';

import '../../../domain/entities/movie.dart';

class MovieZontalListView extends StatelessWidget {
  final List<Movie> movies;
  final String? titile;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const MovieZontalListView(
      {super.key,
      required this.movies,
      this.loadNextPage,
      this.titile,
      this.subTitle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if (titile != null || subTitle != null)
            _Title(
              title: titile,
              subTitle: subTitle,
            )
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subTitle;
  const _Title({this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (title != null)
            Text(
              title!,
              style: titleStyle,
            ),
          const Spacer(),
           if (subTitle != null)
            FilledButton.tonal(
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: () {
                
              },
              child: Text(subTitle!),
            ),
        ],
      ),
    );
  }
}
