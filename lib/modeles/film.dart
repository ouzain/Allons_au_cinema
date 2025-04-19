class Film implements Comparable {
  int? id;
  String? titre;
  double? note;
  String? dateDeSortie;
  String? resume;
  String? urlAffiche;

  Film();

  Film.fromJson(Map<String, dynamic> json) {
    id           = json['id'];
    titre        = json['title'];
    note         = (json['vote_average'] as num?)?.toDouble();
    dateDeSortie = json['release_date'];
    resume       = json['overview'];
    urlAffiche   = json['poster_path'];
  }

  @override
  int compareTo(other) {
    if (note == null || other.note == null) return 0;
    if (note! > other.note) return -1;    // ordre décroissant par défaut
    if (note! < other.note) return 1;
    return 0;
  }
}
