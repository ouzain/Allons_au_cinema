import 'package:flutter/material.dart';
import '../modeles/film.dart';

class DetailFilm extends StatelessWidget {
  final Film film;
  const DetailFilm({super.key, required this.film});

  @override
  Widget build(BuildContext context) {
    const String baseBig = 'https://image.tmdb.org/t/p/w500/';
    const String imgDef  =
        'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';

    final imgUrl = film.urlAffiche != null
        ? '$baseBig${film.urlAffiche}'
        : imgDef;

    return Scaffold(
      appBar: AppBar(title: Text(film.titre ?? '')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              height: MediaQuery.of(context).size.height / 1.5,
              child: Image.network(imgUrl, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                film.resume ?? 'Aucun résumé disponible.',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
