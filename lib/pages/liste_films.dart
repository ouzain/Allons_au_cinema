import 'package:flutter/material.dart';
import '../utils/http_helper.dart';
import '../modeles/film.dart';
import 'detail_film.dart';

class ListeFilms extends StatefulWidget {
  const ListeFilms({super.key});

  @override
  State<ListeFilms> createState() => _ListeFilmsState();
}

class _ListeFilmsState extends State<ListeFilms> {
  final HttpHelper _helper = HttpHelper();

  List<Film> _films = [];
  int _nbFilms = 0;

  // recherche & tri
  Icon _iconVisible          = const Icon(Icons.search);
  Widget _barreRecherche         = const Text('Films');
  bool _ordreInverse        = false;

  @override
  void initState() {
    super.initState();
    _initialiser();
  }

  Future<void> _initialiser() async {
    _films = await _helper.recevoirNouveauxFilms();
    setState(() => _nbFilms = _films.length);
  }

  Future<void> _rechercher(String texte) async {
    _films = await _helper.rechercherFilms(texte);
    setState(() => _nbFilms = _films.length);
  }

  void _trier() {
    setState(() {
      _films.sort();
      if (_ordreInverse) _films = _films.reversed.toList();
      _ordreInverse = !_ordreInverse;
    });
  }

  @override
  Widget build(BuildContext context) {
    const String baseMini = 'https://image.tmdb.org/t/p/w92/';
    const String imgDef   =
        'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';

    return Scaffold(
      appBar: AppBar(
        title: _barreRecherche,
        backgroundColor: Colors.green,
        actions: [
          
          IconButton(
            icon: Icon(_ordreInverse ? Icons.sort_by_alpha : Icons.sort),
            onPressed: _trier,
            tooltip: 'Trier par note',
          ),

          IconButton(
            icon: _iconVisible,
            onPressed: () {
              setState(() {
                if (_iconVisible.icon == Icons.search) {
                  _iconVisible = const Icon(Icons.cancel);
                  _barreRecherche  = TextField(
                    textInputAction: TextInputAction.search,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                    onSubmitted: _rechercher,
                  );
                } else {
                  _iconVisible = const Icon(Icons.search);
                  _barreRecherche  = const Text('Films');
                  _initialiser();
                }
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _nbFilms,
        itemBuilder: (ctx, pos) {
          final film = _films[pos];
          final img  = film.urlAffiche != null
              ? '$baseMini${film.urlAffiche}'
              : imgDef;

          return Card(
            child: ListTile(
              leading: CircleAvatar(backgroundImage: NetworkImage(img)),
              title: Text(film.titre ?? ''),
              subtitle: Text(
                  'Date de sortie : ${film.dateDeSortie ?? 'inconnue'} - '
                  'Note : ${film.note?.toStringAsFixed(1) ?? 'N/A'}',
                ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DetailFilm(film: film)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
